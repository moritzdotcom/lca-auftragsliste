class AddReleasedToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :released, :boolean
  end
end
