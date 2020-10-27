class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.integer :task_number
      t.references :house, null: false, foreign_key: true
      t.references :flat, foreign_key: true
      t.references :tenant, foreign_key: true
      t.string :partner_array
      t.string :partner_names
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :due_date
      t.integer :status
      t.integer :priority
      t.integer :year

      t.timestamps
    end
  end
end
