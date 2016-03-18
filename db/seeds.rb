# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create name: "Chema", email: "che@che.com", password: 12345678
User.create name: "Rachel", email: "rach@rach.com", password: 12345678
User.create name: "Christopher", email: "chris@chris.com", password: 12345678

Team.create name: "Racing de Santander", tshirt_color: "green", address: 'Avenida de El Sardinero'
Team.create name: "Celta de Vigo", tshirt_color: "blue", address: 'Vigo'
Team.create name: "Steagua de Bucarest", tshirt_color: "red", address: 'Bucaresti'
Team.create name: "Valencia CF", tshirt_color: "black", address: 'Mestalla'

Match.create venue: "Calle Cadiz s/n", date: Time.now, price: 30.0, creator_id: 1

