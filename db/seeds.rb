# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#seed hotels
hotel = {}

ActiveRecord::Base.transaction do
  city = ["Kuala Lumpur","Phuket","Bali"]
  country = ["Malaysia", "Thailand", "Indonesia"]
  hotels= [
    'Aria Hotel Budapest by Library Hotel Collection',
    'Mandapa, A Ritz-Carlton Reserve',
    'Turin Palace Hotel',
    'Hotel The Serras',
    'BoHo Prague Hotel',
    'Portrait Firenze',
    'Shinta Mani Shack',
    'Hanoi La Siesta Hotel & Spa',
    'Tulemar Bungalows & Villas',
    'JA Manafaru',
    'Kandolhu',
    'Hotel Eclat',
    'Calabash Luxury Boutique Hotel',
    'The Tuscany',
    'Belmond Palacio Nazarenas',
    'The Nantucket Hotel & Resort',
    "Valle D'incanto Midscale Hotel",
    'Lindos Blu',
    'The Leela Palace Udaipur',
    'Hotel 41',
    'Umaid Bhawan Palace Jodhpur',
    'Hotel Estalagem St Hubertus',
    'The Alpina Gstaad',
    'Constance Prince Maurice',
    'Herods Vitalis Spa Hotel'
  ]
  i = 0
  25.times do
    hotel['description'] = Faker::Hipster.sentence
    hotel['city'] = city.sample
    hotel['country'] = country.sample
    hotel['user_id'] = 5
    hotel['price'] = rand(10..100)
    hotel['rating'] = rand(1..5)
    hotel['hotel_name'] = hotels[i]
    i += 1
    Hotel.create(hotel)
  end
end
