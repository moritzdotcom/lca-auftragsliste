class Task < ApplicationRecord
  belongs_to :house
  belongs_to :flat, optional: true
  belongs_to :tenant, optional: true
  belongs_to :user

  validates :status, inclusion: 0..3
  validates_presence_of :house_id, message: 'Objekt muss angegeben werden'
  validates_presence_of :user_id, message: 'Auftrag braucht einen Verantwortlichen'
  validates_presence_of :title, message: 'Beschreibung muss angegeben werden'
  validates_uniqueness_of :task_number, scope: :year, message: 'Auftragsnummer ist schon vergeben'

  before_validation :set_default_values

  def self.next_number
    Task.where(year: Date.today.year).maximum(:task_number).to_i + 1
  end

  def self.status_options
    ['Offen', 'Wird erledigt', 'Erledigt', 'Problem']
  end

  def prefix_number
    "#{created_at.strftime('%y')}-#{task_number}"
  end

  def partners
    self.partner_array ?  Partner.where(id: self.partner_array.split(';&')) : []
  end

  def humanized_status
    Task.status_options[status]
  end

  private

  def set_default_values
    self.partner_names ||= partners.map { |partner| partner.name }.sort.join(' & ')
    self.status ||= 0
    self.task_number ||= Task.next_number
    self.created_at ||= DateTime.now
    self.year ||= self.created_at.year
  end
end
