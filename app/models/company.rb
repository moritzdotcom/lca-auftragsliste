class Company < ApplicationRecord
  has_many :users
  has_many :tasks
  has_many :partners
  has_many :owners

  has_one_attached :logo
  has_one_attached :pdf_logo

  validates_presence_of :name, message: 'Name muss angegeben werden'
  validates_uniqueness_of :email, message: 'Email ist schon vergeben'

  after_create :set_uuid

  private

  def set_uuid
    self.update(uuid: SecureRandom.uuid)
  end
end
