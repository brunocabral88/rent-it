# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Helper functions
def open_asset(file_name)
  File.open(Rails.root.join('db', 'seed_assets', file_name))
end

puts 'Seeding data'

# Seed users

puts 'Seeding users'
User.destroy_all

user1 = User.create(name: Faker::Name.name,
                    email: 'john@smith.com',
                    phone: Faker::PhoneNumber.cell_phone,
                    password: 'password',
                    password_confirmation: 'password')

user2 = User.create(name: Faker::Name.name,
                    email: 'jane@smith.com',
                    phone: Faker::PhoneNumber.cell_phone,
                    password: 'password',
                    password_confirmation: 'password')

user3 = User.create(name: Faker::Name.name,
                    email: 'jack@smith.com',
                    phone: Faker::PhoneNumber.cell_phone,
                    password: 'password',
                    password_confirmation: 'password')


# Seed tools
puts 'Seeding tools'
Tool.destroy_all

tool1 = Tool.create(name: 'Hammer',
                    description: Faker::Hipster.sentence,
                    owner: user1,
                    picture: open_asset('hammer.jpg'),
                    lat: 43.644796,
                    lng: -79.395154,
                    deposit: 30,
                    daily_rate: 3.5,
                    city: 'Toronto',
                    province: 'ON',
                    category: 'Hand Tools',
                    availability: false)

tool2 = Tool.create(name: 'Screwdriver',
                    description: Faker::Hipster.sentence,
                    owner: user2,
                    picture: open_asset('screwdriver.jpg'),
                    lat: 43.645285,
                    lng: -79.394618,
                    deposit: 20,
                    daily_rate: 2.5,
                    city: 'Toronto',
                    province: 'ON',
                    category: 'Hand Tools',
                    availability: true)

tool3 = Tool.create(name: 'Drill',
                    description: Faker::Hipster.sentence,
                    owner: user2,
                    picture: open_asset('drill.jpg'),
                    lat: 43.654404,
                    lng:  -79.380704,
                    deposit: 100,
                    daily_rate: 11.25,
                    city: 'Toronto',
                    province: 'ON',
                    category: 'Hand Tools',
                    availability: true)


puts 'Seeding rentals'
Rental.destroy_all

rental1 = Rental.create(renter: user3,
                        tool: tool2,
                        start_date: Faker::Date.backward(5),
                        end_date: Date.today,
                        rating: Faker::Number.rand_in_range(1, 5),
                        comment: Faker::Hipster.sentence
)

rental2 = Rental.create(renter: user1,
                        tool: tool1,
                        start_date: Date.today,
                        end_date: Faker::Date.forward(10))
puts 'Done!'