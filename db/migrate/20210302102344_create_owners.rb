class CreateOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :owners do |t|
      t.string :name
      t.string :address
      t.string :postal_code
      t.string :city
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
