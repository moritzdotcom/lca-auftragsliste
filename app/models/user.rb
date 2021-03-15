class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :company
  has_many :tasks

  has_one_attached :profile_picture

  validates_presence_of :first_name, message: 'Vorname muss angegeben werden'
  validates_presence_of :last_name, message: 'Nachname muss angegeben werden'
  validates_presence_of :email, message: 'Email muss angegeben werden'

  scope :for_company, -> (company) { where(company: company) }
  scope :is_partner_in, -> (company) { where(email: company.partners.pluck(:email).uniq) }

  after_create :make_admin_if_first_in_company

  def abbreviated_name
    abbr_name = "#{first_name.first.upcase}#{last_name.first.upcase}"

    if %w(SS AH HH NS HJ KZ SA).include?(abbr_name)
      first_name.chars[1..].each do |char|
        abbr_name = "#{first_name.first.upcase}#{char.upcase}"
        return abbr_name unless %w(SS AH HH NS HJ KZ SA).include?(abbr_name)
      end
    end

    return abbr_name
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def can_edit_task(task)
    self.superadmin || self.company == task.company && (self.admin || task.user == self)
  end

  def self.sign_up_steps
    ['Firma Erstellen', 'Registrieren', 'Email bestätigen']
  end

  private

  def make_admin_if_first_in_company
    self.update(admin: self.company.users.count == 1)
  end
end
