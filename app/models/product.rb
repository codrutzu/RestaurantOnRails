class Product < ApplicationRecord
  has_one_attached :image
  validates :title, :description, :price, :image, presence: true
end
