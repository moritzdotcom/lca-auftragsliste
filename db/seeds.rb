require 'csv'

athome = Company.create(name: 'AtHome Hausverwaltung GmbH')

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = Rails.root.join('db', 'tables_csv', 'partners.csv')

if File.file?(filepath)
  CSV.foreach(filepath, csv_options) do |row|
    Partner.create!(id: row['id'], name: row['name'], email: row['email'], phone_number: row['phone_number'], company: athome, created_at: row['created_at'], updated_at: row['updated_at'])
  end
end

users = [
  { first_name: "Moritz", last_name: "Löchner", email: "moritz.loechner@loechner-immo.de", phone_number: '0211 522 884-10', password: 'halloml', password_confirmation: 'halloml', admin: true, superadmin: true, company: athome },
  { first_name: "Reinhard", last_name: "Löchner", email: "r.loechner@loechner-capital.de", phone_number: '0211 522 884-10', password: 'hallorl', password_confirmation: 'hallorl', company: athome },
  { first_name: "Hermann", last_name: "Scheulen", email: "h.scheulen@loechner-immo.de", phone_number: '0211 522 884-13', mobile_phone: '0151 151 551 02', password: 'hallohs', password_confirmation: 'hallohs', company: athome },
  { first_name: "Christiane", last_name: "Schlenke", email: "c.schlenke@athome-immo.de", phone_number: '0211 522 884-21', password: 'hallocs', password_confirmation: 'hallocs', company: athome },
  { first_name: "Karen", last_name: "Wensing", email: "k.wensing@athome-immo.de", phone_number: '0211 522 884-22', password: 'hallokw', password_confirmation: 'hallokw', company: athome },
  { first_name: 'Tim', last_name: 'Hentschel', email: 'timhentschel38@gmail.com', password: 'halloth', password_confirmation: 'halloth', company: athome },
  { first_name: 'Stephan', last_name: 'Schnitzler', email: 'hausmeister.schnitzler@gmail.com', password: 'hallost', password_confirmation: 'hallost', company: athome },
  { first_name: 'Gwendoline', last_name: 'Löchner', email: 'g.loechner@athome-immo.com', password: 'hallogl', password_confirmation: 'hallogl', company: athome }
]

users.each do |user|
  User.create!(user)
end

filepath = Rails.root.join('db', 'tables_csv', 'houses.csv')

if File.file?(filepath)
  CSV.foreach(filepath, csv_options) do |row|
    House.create!(id: row['id'], address: row['address'], postal_code: row['postal_code'], city: row['city'], company: athome, object_number: row['object_number'], user_id: row['user_id'], created_at: row['created_at'], updated_at: row['updated_at'])
  end
end

filepath = Rails.root.join('db', 'tables_csv', 'flats.csv')

if File.file?(filepath)
  CSV.foreach(filepath, csv_options) do |row|
    Flat.create!(id: row['id'], location: row['location'], house_id: row['house_id'], created_at: row['created_at'], updated_at: row['updated_at'])
  end
end

filepath = Rails.root.join('db', 'tables_csv', 'tenants.csv')

if File.file?(filepath)
  CSV.foreach(filepath, csv_options) do |row|
    Tenant.create!(id: row['id'], name: row['name'], phone_number: row['phone_number'], flat_id: row['flat_id'], created_at: row['created_at'], updated_at: row['updated_at'])
  end
end

filepath = Rails.root.join('db', 'tables_csv', 'tasks.csv')

if File.file?(filepath)
  CSV.foreach(filepath, csv_options) do |row|
    Task.create!(id: row['id'], task_number: row['task_number'], house_id: row['house_id'], flat_id: row['flat_id'], tenant_id: row['tenant_id'], partner_array: row['partner_array'], partner_names: row['partner_names'], user_id: row['user_id'], title: row['title'], description: row['description'], due_date: row['due_date'], status: row['status'], priority: row['priority'], year: row['year'], mail_sent: row['mail_sent'], company: athome, created_at: row['created_at'], updated_at: row['updated_at'])
  end
end
