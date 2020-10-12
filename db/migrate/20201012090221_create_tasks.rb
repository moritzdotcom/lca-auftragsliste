class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.integer :task_number
      t.references :house, null: false, foreign_key: true
      t.references :flat, null: false, foreign_key: true
      t.references :tenant, null: false, foreign_key: true
      t.string :location
      t.string :partner_array
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :due_date

      t.timestamps
    end
  end
end
