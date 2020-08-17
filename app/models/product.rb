class Product < ApplicationRecord
  has_one_attached :image
  validates :title, :description, :price, :image, presence: true
  has_many :cart_products
  has_many :carts, through: :cart_products
end
