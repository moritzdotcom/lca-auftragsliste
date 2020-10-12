class CreateFlats < ActiveRecord::Migration[6.0]
  def change
    create_table :flats do |t|
      t.string :location
      t.references :house, null: false, foreign_key: true

      t.timestamps
    end
  end
end
