class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.string :address
      t.string :postal_code
      t.string :city
      t.references :company, null: false, foreign_key: true
      t.integer :object_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
