class Flat < ApplicationRecord
  belongs_to :house
  has_many :tenants

  validates :location, presence: true

  def current_tenant
    self.tenants.last
  end
end
