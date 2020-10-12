class House < ApplicationRecord
  belongs_to :user
  has_many :flats
end
