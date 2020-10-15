class Task < ApplicationRecord
  belongs_to :house
  belongs_to :flat, optional: true
  belongs_to :tenant, optional: true
  belongs_to :user

  validates :status, inclusion: 0..3

  before_validation :set_default_values

  def self.next_number
    Task.maximum(:task_number).to_i + 1
  end

  def prefix_number
    "#{created_at.strftime('%y')}-#{task_number}"
  end

  def partners
    self.partner_array ? self.partner_array.split(';&').map { |partner_id| Partner.find(partner_id) } : []
  end

  def partner_names
    partners.map { |partner| partner.name }.join(' ')
  end

  def humanized_status
    ['Offen', 'Wird erledigt', 'Erledigt', 'Problem'][status]
  end

  private

  def set_default_values
    self.status ||= 0
    self.task_number ||= Task.next_number
  end
end
