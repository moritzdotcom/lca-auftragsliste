class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks
  has_many :company_users
  has_many :companies, through: :company_users

  validates_presence_of :first_name, message: 'Vorname muss angegeben werden'
  validates_presence_of :last_name, message: 'Nachname muss angegeben werden'
  validates_presence_of :email, message: 'Email muss angegeben werden'

  def abbreviated_name
    "#{first_name.first.upcase}#{last_name.first.upcase}"
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
