class Tenant < ApplicationRecord
  belongs_to :flat
  has_many :tasks, dependent: :nullify

  validates :name, presence: true
end
