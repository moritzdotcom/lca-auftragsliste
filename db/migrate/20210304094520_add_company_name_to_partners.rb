class AddCompanyNameToPartners < ActiveRecord::Migration[6.0]
  def change
    add_column :partners, :company_name, :string
  end
end
