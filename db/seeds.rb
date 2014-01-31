# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Company.delete_all
company = Company.new(name: 'Cambio Gales', url: 'http://www.gales.com.uy/home/', search: '.maq_contenido .monedas tr')
company.id = 1
company.save
company = Company.new(name: 'Cambio 18', url: 'http://www.cambio18.com/', search: 'table')
company.id = 2
company.save
company = Company.new(name: 'Fortex', url: 'http://www.fortex.com.uy/sitio/index.php?lang=es', search: '#sideBar #cotizacion ul')
company.id = 3
company.save
company = Company.new(name: 'Nixus', url: 'http://www.nixus.com.uy/?gclid=CNGZyr-elbwCFelZ7AodmUcAkw', search: '#AutoNumber21')
company.id = 4
company.save
company = Company.new(name: 'Cambio Sir', url: 'http://www.cambiosir.com.uy/', search: '#cotizacionesLeft table tr')
company.id = 5
company.save
company = Company.new(name: 'Cambio Suizo', url: 'http://www.cambiosuizo.com.uy/barrafija2.php', search: 'table table')
company.id = 6
company.save

company = Company.new(name: 'Bacacay', url: 'http://www.bacacaysf.com/cotizaciones.php', search: '.content table table tr')
company.id = 7
company.save

company = Company.new(name: 'Varlix', url: 'http://www.varlix.com.uy/', search: '.cotizacion table tr')
company.id = 8
company.save

Currency.delete_all
currency = Currency.new(name: 'Dólar', code: 'USD')
currency.id = 1
currency.save
