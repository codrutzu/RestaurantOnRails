# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(name: "Codreanu Andrei",
#              email: "codandrei12@gmail.com",
#              password: "foobar",
#              password_confirmation: "foobar",
#              admin: true,
#              activated: true,
#              activated_at: Time.zone.now)

# 99.times do |n|
#   name = Faker::Name.name
#   email = "example-#{n-1}@railstutorial.org"
#   password = "password"
#   User.create!(name: name,
#                email: email,
#                password: password,
#                password_confirmation: password,
#                activated: true,
#                activated_at: Time.zone.now)
# end

30.times do |n|
  title = 'Test'
  description = 'test'
  price = 12
  p = Product.new(title: title,
                  description: description,
                  price: price
                  )
  p.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default.png')), filename: 'default.png')
  p.save!
end
