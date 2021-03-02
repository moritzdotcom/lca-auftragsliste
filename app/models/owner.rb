class Owner < ApplicationRecord
  belongs_to :company
  has_many :houses
end
