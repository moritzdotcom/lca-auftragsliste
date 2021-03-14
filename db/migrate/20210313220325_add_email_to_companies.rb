class AddEmailToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :email, :string
    add_column :companies, :uuid, :uuid

    add_index :companies, :uuid, unique: true
  end
end
