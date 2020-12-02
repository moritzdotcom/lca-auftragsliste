class House < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :flats

  def formatted_address
    "#{address}, #{postal_code} #{city}"
  end
end
