class CreateTenants < ActiveRecord::Migration[6.0]
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :phone_number
      t.references :flat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
