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

admin = User.create(name: Faker::Name.name,
                    email: 'admin@email.com',
                    phone: Faker::PhoneNumber.cell_phone,
                    password: 'password',
                    password_confirmation: 'password',
                    admin: true)

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

user4 = User.create(name: Faker::Name.name,
                    email: 'joan@smith.com',
                    phone: Faker::PhoneNumber.cell_phone,
                    password: 'password',
                    password_confirmation: 'password')


1..50.times do |n|
  admin = (n == 1) ? true : false
  User.create(
    name: Faker::Name.name,
    email: "user#{n}@example.org",
    phone: Faker::PhoneNumber.cell_phone,
    password: "password",
    password_confirmation: "password",
    admin: admin
  )
end

# Seed tools
puts 'Seeding tools'
Tool.destroy_all
Category.destroy_all

hand_tool = Category.create(name: 'Hand Tool')
cleaning = Category.create(name: 'Cleaning')
ladder_and_scaffoldding = Category.create(name: 'Ladder and Scaffolding')

tool1 = Tool.create(name: 'Hammer',
                    description: Faker::Hipster.sentence,
                    owner: user1,
                    picture: open_asset('hammer.jpg'),
                    street_address: '30 Spadina Ave.',
                    deposit: 30,
                    daily_rate: 3.5,
                    city: 'Toronto',
                    province: 'ON',
                    full_address: "46 Spadina Ave, Toronto, ON",
                    category: hand_tool,
                    availability: true)

tool2 = Tool.create(name: 'Screwdriver',
                    description: Faker::Hipster.sentence,
                    owner: user2,
                    picture: open_asset('screwdriver.jpg'),
                    street_address: '48 Spadina Ave.',
                    deposit: 20,
                    daily_rate: 2.5,
                    city: 'Toronto',
                    province: 'ON',
                    category: hand_tool,
                    availability: true)


tool3 = Tool.create(name: 'Drill',
                    description: Faker::Hipster.sentence,
                    owner: user2,
                    picture: open_asset('drill.jpg'),
                    street_address: '52 Spadina Ave.',
                    deposit: 100,
                    daily_rate: 11.25,
                    city: 'Toronto',
                    province: 'N',
                    category: hand_tool,
                    availability: true)

tool4 = Tool.create(name: 'Vacuum Cleaner',
                    description: Faker::Hipster.sentence,
                    owner: user4,
                    picture: open_asset('vacuum_cleaner.jpg'),
                    street_address: '46 Spadina Ave.',
                    deposit: 200,
                    daily_rate: 12.35,
                    city: 'Toronto',
                    province: 'ON',
                    category: cleaning,
                    availability: true)


tool5 = Tool.create(name: 'Hammer - 2',
                    description: Faker::Hipster.sentence,
                    owner: user1,
                    picture: open_asset('hammer.jpg'),
                    street_address: '30 Spadina Ave.',
                    deposit: 30,
                    daily_rate: 3.5,
                    city: 'Toronto',
                    province: 'ON',
                    full_address: "46 Spadina Ave, Toronto, ON",
                    category: hand_tool,
                    availability: true)

tool6 = Tool.create(name: 'Hammer - 3',
                    description: Faker::Hipster.sentence,
                    owner: user1,
                    picture: open_asset('hammer.jpg'),
                    street_address: '39 Spadina Ave.',
                    deposit: 30,
                    daily_rate: 3.5,
                    city: 'Toronto',
                    province: 'ON',
                    full_address: "46 Spadina Ave, Toronto, ON",
                    category: hand_tool,
                    availability: true)

tool7 = Tool.create(name: 'Hammer - 4',
                    description: Faker::Hipster.sentence,
                    owner: user1,
                    picture: open_asset('hammer.jpg'),
                    street_address: '20 Spadina Ave.',
                    deposit: 30,
                    daily_rate: 3.5,
                    city: 'Toronto',
                    province: 'ON',
                    full_address: "46 Spadina Ave, Toronto, ON",
                    category: hand_tool,
                    availability: true)

puts 'Seeding rentals'
Rental.destroy_all
RentalItem.destroy_all
Review.destroy_all

rental1 = Rental.new(renter: user3, start_date: Faker::Date.backward(5), end_date: Date.today, total_cents: 200, stripe_charge_id: 1)
rental1.tools << [tool1, tool2]
rental1.save!

rental2 = Rental.new(renter: user1, start_date: Faker::Date.backward(3), end_date: Date.today, total_cents: 400, stripe_charge_id: 2)
rental2.tools << tool3
rental2.save!

rental3 = Rental.new(renter: user2, start_date: Faker::Date.backward(5), end_date: 3.days.ago, total_cents: 100, stripe_charge_id: 3)
rental3.tools << tool4
rental3.save!


rental4 = Rental.new(renter: user2, start_date: Date.today, end_date: 3.days.from_now, total_cents: 300, stripe_charge_id: 4)
rental4.tools << tool1
rental4.save!

1..60.times do |n|
  start_date = Faker::Date.backward(Random.rand(120))
  returned = Random.rand(2) == 1 ? true : false
  rental = Rental.new(
    renter: User.find(Random.rand(User.count-1)+1),
    start_date: start_date,
    end_date: start_date + Random.rand(10),
    returned: returned,
    stripe_charge_id: "12323113"
    )
  total_rate = 0
  1..Random.rand(Tool.count).times do |y|
    tool = y == 0 ? Tool.find(y+1) : Tool.find(y)
    total_rate += tool.daily_rate * (rental.end_date - start_date).to_i
    rental.tools << tool
  end
  total_cents = total_rate.to_i * 100
  rental.total_cents = total_cents
  rental.save!
end


puts 'Seeding reviews'
Review.create(rental_item: rental1.rental_items.first, rating: 5, comment: Faker::Hacker.say_something_smart)
Review.create(rental_item: rental1.rental_items.second, rating: 3, comment: Faker::Hacker.say_something_smart)
Review.create(rental_item: rental2.rental_items.first, rating: 2, comment: Faker::Hacker.say_something_smart)
puts 'Done!'