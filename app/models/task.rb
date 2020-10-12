class Task < ApplicationRecord
  belongs_to :house
  belongs_to :flat, optional: true
  belongs_to :tenant, optional: true
  belongs_to :user

  def partners
    self.partner_array.split(';&').map { |partner_id| Partner.find(partner_id) }
  end
end
