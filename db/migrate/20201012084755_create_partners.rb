class CreatePartners < ActiveRecord::Migration[6.0]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
