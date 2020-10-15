class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  def abbreviated_name
    "#{first_name.first.upcase}#{last_name.first.upcase}"
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
