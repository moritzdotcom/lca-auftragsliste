class Task < ApplicationRecord
  belongs_to :house
  belongs_to :flat
  belongs_to :tenant
  belongs_to :partner
  belongs_to :user
end
