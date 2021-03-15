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
                               image: File.open(Rails.root.join('app', 'assets', 'images', 'product', 'pizza.svg')),
                               category: Category.find_or_create_by!(name: 'Pizza')
                               )
  end
  3.times do |n|
    Product.create!(title: "Burger #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               image: File.open(Rails.root.join('app', 'assets', 'images','product', 'burger.svg')),
                               category: Category.find_or_create_by!(name: 'Burger')
                               )
  end
  4.times do |n|
    Product.create!(title: "Salad #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               image: File.open(Rails.root.join('app', 'assets', 'images','product', 'salad.svg')),
                               category: Category.find_or_create_by!(name: 'Salad')
                               )
  end
  4.times do |n|
    Product.create!(title: "Pasta #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               image: File.open(Rails.root.join('app', 'assets', 'images',  'product', 'pasta.svg')),
                               category: Category.find_or_create_by!(name: 'Pasta')
                               )
  end
  6.times do |n|
    Product.create!(title: "Taco #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               image: File.open(Rails.root.join('app', 'assets', 'images','product', 'taco.svg')),
                               category: Category.find_or_create_by!(name: 'Taco')
                               )
  end
  2.times do |n|
    Product.create!(title: "Salad #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               image: File.open(Rails.root.join('app', 'assets', 'images', 'product', 'salad.svg')),
                               category: Category.find_or_create_by!(name: 'Salad')
                               )
  end
  4.times do |n|
    Product.create!(title: "Cake #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               image: File.open(Rails.root.join('app', 'assets', 'images','product','dessert.svg')),
                               category: Category.find_or_create_by!(name: 'Dessert')
                               )
  end
end

if Rails.env.production?
  5.times do |n|
    Product.create!(title: "Pizza #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               remote_image_url: "https://res.cloudinary.com/ddgjr1vra/image/upload/v1615834112/pizza_xepjjr.svg",
                               category: Category.find_or_create_by!(name: 'Pizza')
                               )
  end
  3.times do |n|
    Product.create!(title: "Burger #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               remote_image_url: "https://res.cloudinary.com/ddgjr1vra/image/upload/v1615834112/burger_axnhyc.svg",
                               category: Category.find_or_create_by!(name: 'Burger')
                               )
  end
  2.times do |n|
    Product.create!(title: "Salad #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               remote_image_url: "https://res.cloudinary.com/ddgjr1vra/image/upload/v1615834112/salad_hbb1jc.svg",
                               category: Category.find_or_create_by!(name: 'Salad')
                               )
  end
  4.times do |n|
    Product.create!(title: "Pasta #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               remote_image_url: "https://res.cloudinary.com/ddgjr1vra/image/upload/v1615834112/pasta_yoagu8.svg",
                               category: Category.find_or_create_by!(name: 'Pasta')
                               )
  end
  6.times do |n|
    Product.create!(title: "Taco #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               remote_image_url: "https://res.cloudinary.com/ddgjr1vra/image/upload/v1615834700/taco_p7dinj.svg",
                               category: Category.find_or_create_by!(name: 'Taco')
                               )
  end
  4.times do |n|
    Product.create!(title: "Cake #{n}",
                               description: Faker::Lorem.paragraphs.join("\n"),
                               price: Faker::Number.number(digits: 2),
                               weight: Faker::Number.number(digits: 3),
                               remote_image_url: "https://res.cloudinary.com/ddgjr1vra/image/upload/v1615834112/dessert_pn7qrw.svg",
                               category: Category.find_or_create_by!(name: 'Dessert')
                               )
  end
end
