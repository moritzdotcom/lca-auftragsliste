class Partner < ApplicationRecord
  validates_uniqueness_of :phone_number, allow_nil: true, allow_blank: true, message: 'Nummer ist bereits vergeben'
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_nil: true, allow_blank: true
  validates_uniqueness_of :email, allow_nil: true, allow_blank: true, message: 'Email ist bereits vergeben'

  def tasks
    Task.all.filter { |task| task.partner_array && task.partner_array.split(';&').include?(self.id.to_s) }
  end

  def up_to_date
    self.email && self.email.length.positive? && self.phone_number && self.phone_number.length.positive?
  end
end
