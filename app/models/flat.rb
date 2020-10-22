class Flat < ApplicationRecord
  belongs_to :house
  has_many :tenants, dependent: :destroy
  has_many :tasks, dependent: :nullify

  validates :location, presence: true

  def current_tenant
    self.tenants.last
  end

  def tenant_tooltip_info
    return [] unless current_tenant

    [{title: 'Tel.', value: current_tenant.phone_number}]
  end
end
