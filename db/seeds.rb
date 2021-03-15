Category.find_or_create_by!(
  name: 'Dessert'
)

Category.find_or_create_by!(
  name: 'Pizza'
)

Category.find_or_create_by!(
  name: 'Burger'
)

Category.find_or_create_by!(
  name: 'Pasta'
)

Category.find_or_create_by!(
  name: 'Taco'
)

Category.find_or_create_by!(
  name: 'Salad'
)

if Rails.env.development?
  5.times do |n|
    Product.create!(title: "Pizza #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               image: File.open(Rails.root.join('app', 'assets', 'images', 'pizza.svg')),
                               category: Category.find_or_create_by!(name: 'Pizza')
                               )
  end
  3.times do |n|
    Product.create!(title: "Burger #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               image: File.open(Rails.root.join('app', 'assets', 'images', 'burger.svg')),
                               category: Category.find_or_create_by!(name: 'Burger')
                               )
  end
  4.times do |n|
    Product.create!(title: "Salad #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               image: File.open(Rails.root.join('app', 'assets', 'images', 'salad.svg')),
                               category: Category.find_or_create_by!(name: 'Salad')
                               )
  end
  4.times do |n|
    Product.create!(title: "Pasta #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               image: File.open(Rails.root.join('app', 'assets', 'images', 'pasta.svg')),
                               category: Category.find_or_create_by!(name: 'Pasta')
                               )
  end
end
