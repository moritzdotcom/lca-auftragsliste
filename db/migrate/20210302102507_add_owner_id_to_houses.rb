class AddOwnerIdToHouses < ActiveRecord::Migration[6.0]
  def change
    add_reference :houses, :owner, foreign_key: true
  end
end
