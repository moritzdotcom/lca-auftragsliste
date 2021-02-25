
namespace :import do
  task csv: :environment do
    require 'csv'

    csv_filename = Rails.root.join('tasks.csv')

    CSV.read(csv_filename, headers: true, col_sep: ';').each do |row|
      user = User.find_by(last_name: row[6].try(:strip))
      house = House.find_by(object_number: row[2].try(:strip))
      flat = house.flats.find_by(location: row[3].try(:strip)) || Flat.create(house_id: house.id, location: row[3].try(:strip))

      tenant = nil
      if row[4]
        tenant_name = row[4].strip
        if ['herr', 'frau'].include?(tenant_name.split(' ').last.downcase)
          tenant_name = "#{tenant_name.split(' ').last} #{tenant_name.split(' ').first}"
        end
        tenant = flat.tenants.find_by(name: tenant_name) || Tenant.create(flat_id: flat.id, name: tenant_name)
      end

      partner_array = [row[7], row[8]].compact
      partners = partner_array.map { |part| (Partner.find_by(name: part) || Partner.create(name: part, company: house.company)).id }.join(';&')

      task_params = {
        task_number: row[0].split('-').last.to_i,
        house_id: house.id,
        user_id: user.id,
        title: row[5].try(:strip),
        created_at: row[1].to_datetime,
        flat_id: flat.id,
        tenant_id: tenant.try(:id),
        partner_array: partners
      }.compact

      task = Task.new(task_params)
      task.save
    end
  end
end
