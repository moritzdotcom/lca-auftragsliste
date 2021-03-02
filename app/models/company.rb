class Company < ApplicationRecord
  has_many :users
  has_many :tasks
  has_many :partners
  has_many :owners
end
