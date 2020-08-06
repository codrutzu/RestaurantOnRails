class Product < ApplicationRecord
  has_one_attached :image
  validates :title, :description, :price, :image, presence: true
  has_and_belongs_to_many :carts
end
