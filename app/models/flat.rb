class Flat < ApplicationRecord
  belongs_to :house
  has_many :tenants

  validates :location, presence: true

  def current_tenant
    self.tenants.last
  end

  def tenant_tooltip_info
    return [] unless current_tenant

    [{title: 'Tel.', value: current_tenant.phone_number}]
  end
end
