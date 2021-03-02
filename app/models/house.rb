class House < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :flats

  scope :for_company, -> (company) { where(company: company) }

  def formatted_address
    "#{address}, #{postal_code} #{city}"
  end
end
