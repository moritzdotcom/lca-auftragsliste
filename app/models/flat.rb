class Flat < ApplicationRecord
  belongs_to :house
  has_many :tenants

  def current_tenant
    self.tenants.last
  end
end
