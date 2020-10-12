house_array = [ 'Roßstrasse 9', 'Pfalzstrasse 17', 'Schloßstrasse 19', 'Neanderstrasse 15', 'Luisenstrasse 3', 'Lindenstrasse 267', 'Engerstrasse 3', 'Schützenstrasse 20', 'Stockkampstrasse 47', 'Driburgerstrasse 8', 'Kölnerlandstrasse 261', 'Merowingerstrasse 17', 'Borsigstrasse 7', 'Gerresheimer Landstrasse 152', 'Hoppengarten 15', 'Hoppengarten 17', 'Kölner Strasse 215', 'Kölner Strasse 217', 'Alte Bachstrasse 25/27', 'Kranzstrasse 103', 'Broicherdorfstrasse 3', 'Grafenberger Allee 235', 'Börnestrasse 2', 'Angerbenden 31', 'Koppelskamp 10', 'Koppelskamp 12', 'Koppelskamp 14']
flat_array = [[ '01 EG links', '02 EG rechts', '03 1.OG links', '04 1.OG rechts', '05 2.OG links', '06 2.OG rechts', '07 3.OG links', '08 3.OG rechts', '09 DG rechts', '10 DG links'],
              [ '01 EG links', '02 EG rechts', '03 EG hinten', '04 1.OG links', '05 1.OG rechts', '06 2.OG links', '07 2.OG rechts', '08 3.OG links', '09 3.OG rechts', '10 DG links', '11 DG rechts'],
              [ '01 EG links', '02 EG rechts', '03 1.OG links', '04 1.OG rechts', '05 2.OG links', '06 2.OG rechts', '07 3.OG links', '08 3.OG rechts', '09 4.OG links', '10 4.OG rechts', '11 DG links', '12 DG re (Lager)'],
              [ '01 EG links', '02 EG rechts', '03 1.OG links', '04 1.OG mitte', '05 1.OG rechts', '06 2.OG links', '07 2.OG mitte', '08 2.OG rechts', '09 3.OG links', '10 3.OG rechts', '10 3.OG mitte', '11 DG links', '12 DG rechts'],
              [ '01 EG', '02 1.OG', '03 2.OG', '04 3.OG', '05 4.OG', '06 5.OG', '07 DG'],
              [ '01 EG links', '02 EG rechts', '03 1.OG links', '04 1.OG rechts', '05 2.OG links', '06 2.OG rechts', '07 3.OG links', '08 3.OG rechts', '09 4.OG links', '10 4.OG rechts', '11 DG links', '12 DG rechts'],
              [ '01 EG links', '02  EG rechts', '03 1.OG links', '04 1.OG rechts', '05 2.OG links', '06 2.OG rechts', '07 3.OG links', '08 3.OG rechts', '09 4.OG links', '10 4.OG rechts', '11 DG links', '12 DG rechts', '13 Mansarde/ WC', '14 Mansarde Klein'],
              [ '01 EG links', '02 EG rechts', '03 1.OG links', '04 1.OG mitte', '05 1.OG rechts', '06 2.OG links', '07 2.OG mitte', '08 2.OG rechts', '09 3.OG links', '10 3.OG mitte', '11 3.OG rechts', '12 DG links', '13 DG rechts'],
              [ '01 EG links', '02 EG rechts', '03 1.OG links', '04 1.OG rechts', '05 2.OG links', '06 2.OG rechts', '07 3.OG links', '08 3.OG rechts', '09 4.OG links', '10 4.OG rechts', '11 DG links', '12 DG rechts'],
              [ '01 EG links', '02 EG rechts', '03 1.OG links', '04 1.OG rechts', '05 2.OG links', '06 2.OG rechts', '07 3.OG links', '08 3.OG rechts', '09 DG links', '10 DG rechts'],
              [ '01 Laden EG', '02 1.OG links', '02 1.OG rechts', '03 2.OG links', '04 2.OG mitte', '05 2.OG rechts', '06 3.OG links', '07 3.OG mitte', '08 3.OG rechts', '09 DG links', '10 DG rechts'],
              [ '01 EG vorne', '02 EG hinten', '03 1.OG vorne', '04 1.OG hinten', '05 2.OG vorne links', '06 2.OG vorne rechts', '07 2.OG hinten', '08 3.OG vorne links', '09 3.OG vorne rechts', '10 3.OG hinten', '11 DG vorne links', '12 DG vorne rechts'],
              [ '01 UG', '02 EG links', '03 EG rechts', '04 1.OG links', '05 1.OG rechts', '06 2.OG links', '07 2.OG rechts', '08 DG links', '09 DG rechts'],
              [ '01 EG links', '02 EG rechts', '03 1.OG links', '04 1.OG rechts'],
              [ '01 15 EG links', '02 15 EG Rechts', '03 15 1.OG links', '04 15 1.OG rechts', '05 15 DG links', '06 15 DG rechts'],
              [ '01 17 EG links', '02 17 EG rechts', '03 17 1.OG links', '04 17 1.OG rechts', '05 17 DG links', '06 17 DG rechts'],
              [ '01 EG rechts', '01 EG hinten', '03 1.OG links', '04 1.OG rechts', '05 2.OG links', '06 2.OG rechts', '07 3.OG links', '08 3.OG rechts', '09 4.OG links', '10 4.OG rechts', '11 5.OG links', '12 5.OG rechts'],
              [ '01 EG links', '02 EG rechts', '03 1.OG links', '04 1.OG rechts', '05 2.OG links', '06 2.OG rechts', '07 3.OG links', '08 3.OG rechts', '09 4.OG links', '10 4.OG rechts', '11 5.OG links', '12 5.OG rechts'],
              [ '01 EG C', '02 EG D', '03 EG E', '04 1.OG A', '05 1.OG B', '06 1.OG C', '07 1.OG D', '08 1.OG E', '09 2.OG A', '10 2.OG B', '11 2.OG C', '12 2.OG D', '13 2.OG E', '14 3.OG A', '15 3.OG B', '16 3.OG C', '17 3.OG D', '18 3.OG E', '19 4.OG A', '20 4.OG B', '21 4.OG C', '22 4.OG D', '23 4.OG E', '24 5.OG A', '25 5.OG B', '26 5.OG C', '27 5.OG D', '28 5.OG E', '29 6.OG A', '30 6.OG B', '31 6.OG C', '32 Büro EG'],
              [ '01 EG links', '02 EG mitte', '03 EG rechts', '04 1.OG mitte', '05 1.OG links', '06 1.OG rechts', '07 2.OG mitte', '08 2.OG links', '09 2.OG rechts', '10 3.OG links', '11 3.OG mitte / DG', '12 3.OG rechts'],
              [ '01 UG links', '02 UG rechts', '03 EG links', '04 EG rechts', '05 1.OG links', '06 1.OG rechts', '07 2.OG links', '08 2.OG rechts', '09 3.OG links', '10 3.OG rechts'],
              [ '01 EG', '02 1.OG', '03 2.OG', '04 3.OG Whg.', '05 4.OG links', '06 4.OG links hinten', '07 4.OG rechts', '08 DG links', '09 DG rechts'],
              [ '01 EG', '02 1.OG', '03 2.OG', '04 3.OG', '05 4.OG', '06 5.OG'],
              [ '01 EG links', '02 EG rechts', '03 1.OG links', '04 1.OG rechts'],
              [ '01 EG links', '02 EG rechts', '03 1.OG links', '04 1.OG rechts', '05 DG links', '06 DG rechts'],
              [ '01 EG links', '02 EG rechts', '03 1.OG links', '04 1.OG rechts', '05 DG links', '06 DG rechts'],
              [ '01 EG links', '02 EG rechts', '03 1.OG links', '04 1.OG rechts', '05 DG links', '06 DG rechts']]

puts "creating #{house_array.count} houses"

house_array.each_with_index do |address, i|
  house = House.create(address: address)
  flat_array[i].each do |location|
    flat = Flat.new(location: location)
    flat.house = house
    flat.save
  end
end

partners_array = [
  { name: "Hermann Scheulen", email: "h.scheulen@loechner-immo.de" },
  { name: "Andreas Stachon", email: "andreas.stachon66@arcor.de" },
  { name: "Christiane Schlenke", email: "c.schlenke@athome-immo.de" },
  { name: "Karen Wensing", email: "k.wensing@athome-immo.de" },
  { name: "Stephan Schnitzler", email: "hausmeister.schnitzler@gmail.com" },
  { name: "Weber", email: "info@alfons-weber-gmbh.com" },
  { name: "Groten", email: "altbausanierung@jensgroten.de" },
  { name: "Blum", email: "info@fensterservice-blum.de" },
  { name: "Menzel", email: "h.j.menzel@arcor.de" },
  { name: "Immerath", email: "info@immerath-gmbh.de" },
  { name: "Neumann", email: "h.neumann_gmbh@t-online.de" },
  { name: "Tim Hentschel", email: "timhentschel38@gmail.com" },
  { name: "Drezek", email: "a.drezek@gmx.de" },
  { name: "E.I.S", email: "einetter@t-online.de" },
  { name: "Achternbosch", email: "info@achternbosch-kaarst.de" },
  { name: "Rother", email: "info@rother-tore.de" },
  { name: "Wenderholm", email: "info@wbh-dachdeckerei.de" },
  { name: "Juchem", email: "tjuchem@aol.com" },
  { name: "Mainz", email: "kontakt@mainz-elektro.de" },
  { name: "Schmelzer", email: "info@glasschmelzer.de" },
  { name: "Jeroschewski", email: "info@rohrreinigung-jeroschewski.de" },
  { name: "Wingartz", email: "dwingartz@mailisis.de" },
  { name: "Müllers", email: "team@rolladen-muellers.de" },
  { name: "Schott", email: "info@aufzugtechnik-schott.de" },
  { name: "Stötzel", email: "info@stoetzel-rolladen.de" },
  { name: "Koch", email: "i.koch@bodenbelag-koch.de" },
  { name: "Scholl", email: "info@glas-scholl.de" },
  { name: "Küppers", email: "info@schreinerei-kueppers.de" },
  { name: "Sahin", email: "info@elektrosahin.de" },
  { name: "Hess", email: "metallbau-hess@web.de" },
  { name: "Kessner", email: "service@achim-kessner.de" },
  { name: "Kunze", email: "info@marmor-kunze.de" },
  { name: "Blauen Engel", email: "kontakt@die-blauen-Engel.com" },
  { name: "Plociennick", email: "dpsschluesseldienst@gmail.com" },
  { name: "Daschner", email: "auftragsannahme@daschner-gmbh.de" },
  { name: "Zorn", email: "zorn-bedachungen@web.de" },
  { name: "van Acken", email: "vanacken@lustauffarbe.info" },
  { name: "Asbestos", email: "info@aspestosgruppe.de" },
  { name: "Kozlowski", email: "kozlowskijob@gmail.com" },
  { name: "Matter", email: "kontakt@schreinerei-matter.de" },
  { name: "Overlach", email: "aufzugservice.overlach@t-online.de" },
  { name: "Neite", email: "d.grueter@neite-gmbh.de" }
]

partners_array.each do |partner|
  Partner.create(partner)
end
