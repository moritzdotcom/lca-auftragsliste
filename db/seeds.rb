lig = Company.create(name: 'Löchner Immobilien GmbH&Co.KG')
lgi = Company.create(name: 'Löchner Grundbesitz I GmbH&Co.KG')

partners_array = [
  { name: "Hermann Scheulen", email: "h.scheulen@loechner-immo.de", company: lig },
  { name: "Andreas Stachon", email: "andreas.stachon66@arcor.de", company: lig },
  { name: "Christiane Schlenke", email: "c.schlenke@athome-immo.de", company: lig },
  { name: "Karen Wensing", email: "k.wensing@athome-immo.de", company: lig },
  { name: "Stephan Schnitzler", email: "hausmeister.schnitzler@gmail.com", company: lig },
  { name: "Weber", email: "info@alfons-weber-gmbh.com", company: lig },
  { name: "Groten", email: "altbausanierung@jensgroten.de", company: lig },
  { name: "Blum", email: "info@fensterservice-blum.de", company: lig },
  { name: "Menzel", email: "h.j.menzel@arcor.de", company: lig },
  { name: "Immerath", email: "info@immerath-gmbh.de", company: lig },
  { name: "Neumann", email: "h.neumann_gmbh@t-online.de", company: lig },
  { name: "Tim Hentschel", email: "timhentschel38@gmail.com", company: lig },
  { name: "Drezek", email: "a.drezek@gmx.de", company: lig },
  { name: "E.I.S", email: "einetter@t-online.de", company: lig },
  { name: "Achternbosch", email: "info@achternbosch-kaarst.de", company: lig },
  { name: "Rother", email: "info@rother-tore.de", company: lig },
  { name: "Wenderholm", email: "info@wbh-dachdeckerei.de", company: lig },
  { name: "Juchem", email: "tjuchem@aol.com", company: lig },
  { name: "Mainz", email: "kontakt@mainz-elektro.de", company: lig },
  { name: "Schmelzer", email: "info@glasschmelzer.de", company: lig },
  { name: "Jeroschewski", email: "info@rohrreinigung-jeroschewski.de", company: lig },
  { name: "Wingartz", email: "dwingartz@mailisis.de", company: lig },
  { name: "Müllers", email: "team@rolladen-muellers.de", company: lig },
  { name: "Schott", email: "info@aufzugtechnik-schott.de", company: lig },
  { name: "Stötzel", email: "info@stoetzel-rolladen.de", company: lig },
  { name: "Koch", email: "i.koch@bodenbelag-koch.de", company: lig },
  { name: "Scholl", email: "info@glas-scholl.de", company: lig },
  { name: "Küppers", email: "info@schreinerei-kueppers.de", company: lig },
  { name: "Sahin", email: "info@elektrosahin.de", company: lig },
  { name: "Hess", email: "metallbau-hess@web.de", company: lig },
  { name: "Kessner", email: "service@achim-kessner.de", company: lig },
  { name: "Kunze", email: "info@marmor-kunze.de", company: lig },
  { name: "Blauen Engel", email: "kontakt@die-blauen-Engel.com", company: lig },
  { name: "Plociennick", email: "dpsschluesseldienst@gmail.com", company: lig },
  { name: "Daschner", email: "auftragsannahme@daschner-gmbh.de", company: lig },
  { name: "Zorn", email: "zorn-bedachungen@web.de", company: lig },
  { name: "van Acken", email: "vanacken@lustauffarbe.info", company: lig },
  { name: "Asbestos", email: "info@aspestosgruppe.de", company: lig },
  { name: "Kozlowski", email: "kozlowskijob@gmail.com", company: lig },
  { name: "Matter", email: "kontakt@schreinerei-matter.de", company: lig },
  { name: "Overlach", email: "aufzugservice.overlach@t-online.de", company: lig },
  { name: "Neite", email: "d.grueter@neite-gmbh.de", company: lig }
]

partners_array.each do |partner|
  if Partner.find_by(name: partner[:name])
    Partner.find_by(name: partner[:name]).update(partner)
  else
    Partner.create(partner)
  end
end

users = [
  { first_name: "Reinhard", last_name: "Löchner", email: "r.loechner@loechner-capital.de", phone_number: '0211 522 884-10', password: 'hallorl', password_confirmation: 'hallorl' },
  { first_name: "Hermann", last_name: "Scheulen", email: "h.scheulen@loechner-immo.de", phone_number: '0211 522 884-13', mobile_phone: '0151 151 551 02', password: 'hallohs', password_confirmation: 'hallohs' },
  { first_name: "Christiane", last_name: "Schlenke", email: "c.schlenke@athome-immo.de", phone_number: '0211 522 884-21', password: 'hallocs', password_confirmation: 'hallocs' },
  { first_name: "Karen", last_name: "Wensing", email: "k.wensing@athome-immo.de", phone_number: '0211 522 884-22', password: 'hallokw', password_confirmation: 'hallokw' },
  { first_name: "Moritz", last_name: "Löchner", email: "moritz.loechner@loechner-immo.de", phone_number: '0211 522 884-10', password: 'halloml', password_confirmation: 'halloml', admin: true }
]

users.each do |user|
  if User.find_by(first_name: user[:first_name], last_name: user[:last_name])
    User.find_by(first_name: user[:first_name], last_name: user[:last_name]).update(user)
  else
    u = User.create(user)
    comp_one = CompanyUser.create(user: u, company: lig)
    comp_two = CompanyUser.create(user: u, company: lgi)
  end
end


house_array = [
  { object_number: 1, address: 'Roßstraße 9', postal_code: '40476', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 2, address: 'Pfalzstraße 17', postal_code: '40477', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 3, address: 'Schloßstraße 19', postal_code: '40477', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 4, address: 'Neanderstraße 15', postal_code: '40233', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 5, address: 'Luisenstraße 3', postal_code: '40215', city: 'Düsseldorf', user: 'Schlenke', company: lig },
  { object_number: 6, address: 'Lindenstraße 267', postal_code: '40235', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 7, address: 'Engerstraße 3', postal_code: '40235', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 8, address: 'Schützenstraße 20', postal_code: '40211', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 9, address: 'Stockkampstraße 47', postal_code: '40477', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 10, address: 'Driburger Straße 8', postal_code: '40472', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 11, address: 'Kölner Landstraße 261', postal_code: '40591', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 12, address: 'Merowingerstr. 17', postal_code: '40223', city: 'Düsseldorf', user: 'Schlenke', company: lig },
  { object_number: 13, address: 'Borsigstraße 7', postal_code: '40227', city: 'Düsseldorf', user: 'Schlenke', company: lig },
  { object_number: 14, address: 'Gerresheimer Landstraße 152', postal_code: '40627', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 15, address: 'Hoppengarten 15', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 16, address: 'Hoppengarten 17', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 17, address: 'Kölner Straße 215', postal_code: '40227', city: 'Düsseldorf', user: 'Schlenke', company: lig },
  { object_number: 18, address: 'Kölner Straße 217', postal_code: '40227', city: 'Düsseldorf', user: 'Schlenke', company: lig },
  { object_number: 19, address: 'Alte Bachstraße 25', postal_code: '41748', city: 'Viersen', user: 'Schlenke', company: lig },
  { object_number: 20, address: 'Kranzstraße 103', postal_code: '41065', city: 'Mönchengladbach-Lürrip', user: 'Schlenke', company: lig },
  { object_number: 21, address: 'Broicherdorfstraße 3', postal_code: '41564', city: 'Kaarst', user: 'Schlenke', company: lig },
  { object_number: 22, address: 'Grafenberger Allee 235', postal_code: '40237', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 23, address: 'Börnestraße 2', postal_code: '40211', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 24, address: 'Angerbenden 31', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 25, address: 'Koppelskamp 10', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 26, address: 'Koppelskamp 12', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 27, address: 'Koppelskamp 14', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lig },
  { object_number: 28, address: 'Koppelskamp 8', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lgi },
  { object_number: 29, address: 'Bismarckstraße 109', postal_code: '47057', city: 'Duisburg', user: 'Wensing', company: lgi },
  { object_number: 30, address: 'Memelstraße 43', postal_code: '47057', city: 'Duisburg', user: 'Wensing', company: lgi },
  { object_number: 31, address: 'Angermunder Straße 30', postal_code: '47269', city: 'Duisburg', user: 'Wensing', company: lgi },
  { object_number: 32, address: 'Koppelskamp 5', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lgi },
  { object_number: 33, address: 'Koppelskamp 5a', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lgi },
  { object_number: 34, address: 'Koppelskamp 7', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lgi },
  { object_number: 35, address: 'Lintorfer Waldstraße 6', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lgi },
  { object_number: 36, address: 'Lintorfer Waldstraße 8', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lgi },
  { object_number: 37, address: 'Lintorfer Waldstraße 10', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lgi },
  { object_number: 38, address: 'Koloniestraße 205', postal_code: '47057', city: 'Duisburg', user: 'Wensing', company: lgi },
  { object_number: 39, address: 'Metzer Straße 28', postal_code: '47137', city: 'Duisburg', user: 'Schlenke', company: lgi },
  { object_number: 40, address: 'Metzer Straße 28a', postal_code: '47137', city: 'Duisburg', user: 'Schlenke', company: lgi },
  { object_number: 41, address: 'Spichernstraße 27', postal_code: '47137', city: 'Duisburg', user: 'Schlenke', company: lgi },
  { object_number: 42, address: 'Metzer Straße 17', postal_code: '47137', city: 'Duisburg', user: 'Schlenke', company: lgi },
  { object_number: 43, address: 'Neumühler Straße 35', postal_code: '47138', city: 'Duisburg', user: 'Schlenke', company: lgi },
  { object_number: 44, address: 'Neumühler Straße 37', postal_code: '47138', city: 'Duisburg', user: 'Schlenke', company: lgi },
  { object_number: 45, address: 'Neumühler Straße 39', postal_code: '47138', city: 'Duisburg', user: 'Schlenke', company: lgi },
  { object_number: 46, address: 'Neumühler Straße 41', postal_code: '47138', city: 'Duisburg', user: 'Schlenke', company: lgi },
  { object_number: 47, address: 'Mündelheimer Straße 3-5', postal_code: '47259', city: 'Duisburg', user: 'Wensing', company: lgi },
  { object_number: 48, address: 'Mendelsohnstraße 3', postal_code: '40233', city: 'Düsseldorf', user: 'Schlenke', company: lgi },
  { object_number: 49, address: 'Angermunder Straße 69', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lgi },
  { object_number: 50, address: 'Angermunder Straße 71', postal_code: '40489', city: 'Düsseldorf', user: 'Wensing', company: lgi }
]

flat_array = [[ 'EG links', 'EG rechts', '1.OG links', '1.OG rechts', '2.OG links', '2.OG rechts', '3.OG links', '3.OG rechts', 'DG rechts', 'DG links'],
              [ 'EG links', 'EG rechts', 'EG hinten', '1.OG links', '1.OG rechts', '2.OG links', '2.OG rechts', '3.OG links', '3.OG rechts', 'DG links', 'DG rechts'],
              [ 'EG links', 'EG rechts', '1.OG links', '1.OG rechts', '2.OG links', '2.OG rechts', '3.OG links', '3.OG rechts', '4.OG links', '4.OG rechts', 'DG links', 'DG rechts (Lager)'],
              [ 'EG links', 'EG rechts', '1.OG links', '1.OG mitte', '1.OG rechts', '2.OG links', '2.OG mitte', '2.OG rechts', '3.OG links', '3.OG rechts', '3.OG mitte', 'DG links', 'DG rechts'],
              [ 'EG', '1.OG', '2.OG', '3.OG', '4.OG', '5.OG', 'DG'],
              [ 'EG links', 'EG rechts', '1.OG links', '1.OG rechts', '2.OG links', '2.OG rechts', '3.OG links', '3.OG rechts', '4.OG links', '4.OG rechts', 'DG links', 'DG rechts'],
              [ 'EG links', 'EG rechts', '1.OG links', '1.OG rechts', '2.OG links', '2.OG rechts', '3.OG links', '3.OG rechts', '4.OG links', '4.OG rechts', 'DG links', 'DG rechts', 'Mansarde/ WC', 'Mansarde Klein'],
              [ 'EG links', 'EG rechts', '1.OG links', '1.OG mitte', '1.OG rechts', '2.OG links', '2.OG mitte', '2.OG rechts', '3.OG links', '3.OG mitte', '3.OG rechts', 'DG links', 'DG rechts'],
              [ 'EG links', 'EG rechts', '1.OG links', '1.OG rechts', '2.OG links', '2.OG rechts', '3.OG links', '3.OG rechts', '4.OG links', '4.OG rechts', 'DG links', 'DG rechts'],
              [ 'EG links', 'EG rechts', '1.OG links', '1.OG rechts', '2.OG links', '2.OG rechts', '3.OG links', '3.OG rechts', 'DG links', 'DG rechts'],
              [ 'Laden EG', '1.OG links', '1.OG rechts', '2.OG links', '2.OG mitte', '2.OG rechts', '3.OG links', '3.OG mitte', '3.OG rechts', 'DG links', 'DG rechts'],
              [ 'EG vorne', 'EG hinten', '1.OG vorne', '1.OG hinten', '2.OG vorne links', '2.OG vorne rechts', '2.OG hinten', '3.OG vorne links', '3.OG vorne rechts', '3.OG hinten', 'DG vorne links', 'DG vorne rechts'],
              [ 'UG', 'EG links', 'EG rechts', '1.OG links', '1.OG rechts', '2.OG links', '2.OG rechts', 'DG links', 'DG rechts'],
              [ 'EG links', 'EG rechts', '1.OG links', '1.OG rechts'],
              [ 'EG links', 'EG Rechts', '1.OG links', '1.OG rechts', 'DG links', 'DG rechts'],
              [ 'EG links', 'EG rechts', '1.OG links', '1.OG rechts', 'DG links', 'DG rechts'],
              [ 'EG rechts', 'EG hinten', '1.OG links', '1.OG rechts', '2.OG links', '2.OG rechts', '3.OG links', '3.OG rechts', '4.OG links', '4.OG rechts', '5.OG links', '5.OG rechts'],
              [ 'EG links', 'EG rechts', '1.OG links', '1.OG rechts', '2.OG links', '2.OG rechts', '3.OG links', '3.OG rechts', '4.OG links', '4.OG rechts', '5.OG links', '5.OG rechts'],
              [ 'EG C', 'EG D', 'EG E', '1.OG A', '1.OG B', '1.OG C', '1.OG D', '1.OG E', '2.OG A', '2.OG B', '2.OG C', '2.OG D', '2.OG E', '3.OG A', '3.OG B', '3.OG C', '3.OG D', '3.OG E', '4.OG A', '4.OG B', '4.OG C', '4.OG D', '4.OG E', '5.OG A', '5.OG B', '5.OG C', '5.OG D', '5.OG E', '6.OG A', '6.OG B', '6.OG C', 'Büro EG'],
              [ 'EG links', 'EG mitte', 'EG rechts', '1.OG mitte', '1.OG links', '1.OG rechts', '2.OG mitte', '2.OG links', '2.OG rechts', '3.OG links', '3.OG mitte / DG', '3.OG rechts'],
              [ 'UG links', 'UG rechts', 'EG links', 'EG rechts', '1.OG links', '1.OG rechts', '2.OG links', '2.OG rechts', '3.OG links', '3.OG rechts'],
              [ 'EG', '1.OG', '2.OG', '3.OG Whg.', '4.OG links', '4.OG links hinten', '4.OG rechts', 'DG links', 'DG rechts'],
              [ 'EG', '1.OG', '2.OG', '3.OG', '4.OG', '5.OG'],
              [ 'EG links', 'EG rechts', '1.OG links', '1.OG rechts'],
              [ 'EG links', 'EG rechts', '1.OG links', '1.OG rechts', 'DG links', 'DG rechts'],
              [ 'EG links', 'EG rechts', '1.OG links', '1.OG rechts', 'DG links', 'DG rechts'],
              [ 'EG links', 'EG rechts', '1.OG links', '1.OG rechts', 'DG links', 'DG rechts']]

house_array.each_with_index do |house_params, i|
  house_params[:user] = User.find_by(last_name: house_params[:user])
  if House.find_by(object_number: house_params[:object_number])
    house = House.find_by(object_number: house_params[:object_number])
    house.update(house_params)
  else
    house = House.new(house_params)
    house.save!
  end
  if flat_array[i]
    flat_array[i].each do |location|
      next if Flat.find_by(house: house, location: location)

      Flat.create(location: location, house: house)
    end
  end
end


tasks = [
  { task_number: 353, created_at: '02.10.2020', house: 12, flat: '3.OG hinten', tenant: 'Frau Kapr', title: 'Getriebe im Küchenfenster defekt', user: 'Schlenke', partners: ['Blum'] },
  { task_number: 354, created_at: '06.10.2020', house: 8, flat: '1.OG mitte', tenant: 'Frau Schmidt', title: 'Absicherung - Sicherungen prüfen', user: 'Scheulen', partners: ['Andreas Stachon'] },
  { task_number: 355, created_at: '06.10.2020', house: 33, flat: 'SG', tenant: 'Frau Lang', title: 'Rolllade Wohnen Einstellung ändern - Rollladenstopper reparieren', user: 'Scheulen', partners: ['Tim Hentschel', 'Andreas Stachon'] },
  { task_number: 356, created_at: '07.10.2020', house: 36, flat: '1.OG rechts', tenant: 'Herr Schlegel', title: 'Schlafen Rollladenkasten nachstreichen', user: 'Scheulen', partners: ['van Acken'] },
  { task_number: 357, created_at: '07.10.2020', house: 10, flat: '3.OG links', tenant: 'Patti Mazzone', title: 'Überdachung Wellplatten entfernen', user: 'Scheulen', partners: ['Stephan Schnitzler'] },
  { task_number: 358, created_at: '07.10.2020', house: 26, flat: 'DG links', tenant: 'Frau Strehblow', title: 'Gaubenabdichtung-Abläufe ertüchtigen', user: 'Scheulen', partners: ['Zorn'] },
  { task_number: 359, created_at: '07.10.2020', house: 17, flat: '2.OG rechts', tenant: 'Herr Wojtczak', title: 'Fensterflügel Schlafen nachstellen', user: 'Scheulen', partners: ['Blum'] },
  { task_number: 360, created_at: '07.10.2020', house: 10, flat: '2.OG rechts', tenant: 'Leerstand', title: 'Malerarbeiten', user: 'Scheulen', partners: ['van Acken'] },
  { task_number: 361, created_at: '07.10.2020', house: 43, flat: 'DG links', tenant: 'Leerstand', title: 'Grundreinigung', user: 'Scheulen', partners: ['Drezek'] },
  { task_number: 362, created_at: '07.10.2020', house: 43, flat: 'DG links', tenant: 'Leerstand', title: 'Malerarbeiten', user: 'Scheulen', partners: ['van Acken'] },
  { task_number: 363, created_at: '08.10.2020', house: 3, flat: 'DG links', tenant: 'Frau Perla', title: 'tropft aus der Abgasführung Therme', user: 'Scheulen', partners: ['Weber'] },
  { task_number: 364, created_at: '08.10.2020', house: 25, flat: '1.OG rechts', tenant: 'Frau Schreiber', title: 'Rohrverstopfung Küchenstrang', user: 'Scheulen', partners: ['Jeroschewski'] },
  { task_number: 365, created_at: '09.10.2020', house: 19, flat: '4.OG E', tenant: 'Frau Hoti', title: 'Bad Prüfung auf Leckage - Wasserschaden', user: 'Scheulen', partners: ['Immerath'] }
]

tasks.each do |task|
  task[:created_at] = task[:created_at].to_datetime
  task[:house] = House.find_by(object_number: task[:house])
  task[:flat] = Flat.find_by(house: task[:house], location: task[:flat]) || Flat.create(house: task[:house], location: task[:flat])
  task[:tenant] = Tenant.find_by(name: task[:tenant], flat: task[:flat]) || Tenant.create(name: task[:tenant], flat: task[:flat])
  task[:user] = User.find_by(last_name: task[:user])

  partner_array = []
  task[:partners].each do |partner|
    partner_array << Partner.find_by(name: partner).id || Partner.create(name: partner).id
  end
  task[:partner_array] = partner_array.join(';&')
  task[:partners] = nil
  Task.find_by(task_number: task[:task_number]) ? Task.find_by(task_number: task[:task_number]).update(task.compact) : Task.create!(task.compact)
end

