# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Company.delete_all
company_1 = Company.new(name: 'Gales', url: 'http://www.gales.com.uy/home/', search: '.maq_contenido .monedas tr')
company_1.id = 1
company_1.save
company_2 = Company.new(name: 'Cambio 18', url: 'http://www.cambio18.com/', search: 'table')
company_2.id = 2
company_2.save
company_3 = Company.new(name: 'Fortex', url: 'http://www.fortex.com.uy/sitio/index.php?lang=es', search: '#sideBar #cotizacion ul')
company_3.id = 3
company_3.save
company_4 = Company.new(name: 'Nixus', url: 'http://www.nixus.com.uy/?gclid=CNGZyr-elbwCFelZ7AodmUcAkw', search: '#AutoNumber21')
company_4.id = 4
company_4.save

Currency.delete_all
currency = Currency.new(name: 'Dólar', code: 'USD')
currency.id = 1
currency.save
