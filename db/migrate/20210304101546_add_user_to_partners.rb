class AddUserToPartners < ActiveRecord::Migration[6.0]
  def change
    add_reference :partners, :user, foreign_key: true
  end
end
