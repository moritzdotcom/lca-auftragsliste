class Partner < ApplicationRecord
  validates_uniqueness_of :phone_number, allow_nil: true, allow_blank: true
  validates_uniqueness_of :email, allow_nil: true, allow_blank: true

  def tasks
    Task.all.filter { |task| task.partner_array.split(';&').include?(self.id.to_s) }
  end
end
