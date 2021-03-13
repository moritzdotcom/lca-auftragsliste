class Partner < ApplicationRecord
  belongs_to :company
  belongs_to :user, optional: true

  validates_presence_of :name
  validates_uniqueness_of :phone_number, allow_nil: true, allow_blank: true, message: 'Nummer ist bereits vergeben'
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_nil: true, allow_blank: true
  validates_uniqueness_of :email, scope: :company_id, allow_nil: true, allow_blank: true, message: 'Email ist bereits vergeben'

  scope :for_company, -> (company) { where(company: company) }
  scope :is_no_user, -> { where.not(email: User.pluck(:email)) }

  after_create :check_for_user!

  def tasks
    # partner_array edge cases: 1) '1;&11' 2) '11;&1' 3) '11;&1;&111' 4) '1'
    # 1) Task.where('partner_array LIKE ?', "#{self.id};&%")    Partner ist der erste im Array
    # 2) Task.where('partner_array LIKE ?', "%;&#{self.id}")    Partner ist der letzte im Array
    # 3) Task.where('partner_array LIKE ?', "%;&#{self.id};&%") Partner ist in der Mitte des Array
    # 4) Task.where('partner_array IS ?', "#{self.id}")
    # => Task.where('partner_array LIKE ? OR partner_array LIKE ? OR partner_array LIKE ? OR partner_array = ?', "#{self.id};&%", "%;&#{self.id}", "%;&#{self.id};&%", "#{self.id}")
    Task.for_company(self.company).where('partner_array LIKE ? OR partner_array LIKE ? OR partner_array LIKE ? OR partner_array = ?', "#{self.id};&%", "%;&#{self.id}", "%;&#{self.id};&%", "#{self.id}")

    # Slower but reliable
    # Task.all.filter { |task| task.partner_array && task.partner_array.split(';&').include?(self.id.to_s) }
  end

  def up_to_date
    self.email && self.email.length.positive? && self.phone_number && self.phone_number.length.positive?
  end

  def check_for_user!
    return unless self.email && self.email['@']

    self.update(user: User.find_by(email: self.email))
  end

  def set_all_task_names!
    self.tasks.each { |task| task.set_partner_names! }
  end
end

# house_ids = House.pluck(:id)
# flat_ids = Flat.pluck(:id)
# user_ids = User.pluck(:id)
# partner_ids = Partner.pluck(:id)
# title = 'test for partners'
# due_date = Date.tomorrow
# 100.times do
#    task_params = {house_id: house_ids.sample, flat_id: flat_ids.sample, title: title, due_date: due_date, user_id: user_ids.sample}
#    task_params[:partner_array] = (rand(2) == 0 ? [partner_ids.sample, partner_ids.sample].join(';&') : [partner_ids.sample, partner_ids.sample, partner_ids.sample].join(';&'))
#    task_params[:partner_array] = partner_ids.sample.to_s if rand(3) == 0
#    task = Task.new(task_params)
#    task.save
#  end


# def get_tasks_slow(id)
#   timer = Time.now
#   count = Task.all.filter { |task| task.partner_array && task.partner_array.split(';&').include?(id.to_s) }.count
#   { count: count, time: Time.now - timer }
# end

# def get_tasks_fast(id)
#   timer = Time.now
#   count = Task.where('partner_array LIKE ? OR partner_array LIKE ? OR partner_array LIKE ? OR partner_array = ?', "#{id};&%", "%;&#{id}", "%;&#{id};&%", "#{id}").count
#   { count: count, time: Time.now - timer }
# end

# Partner.pluck(:id).each do |id|
#   puts "id: #{id}"
#   slow_count = get_tasks_slow(id)
#   fast_count = get_tasks_fast(id)
#   puts "differenz: #{slow_count[:count] - fast_count[:count]}"
#   puts "Schneller: #{slow_count[:time] - fast_count[:time]}"
# end
