class Product < ApplicationRecord
  has_one_attached :image
  validates :title, :description, :price, :image, presence: true
  has_many :cart_products
  has_many :carts, through: :cart_products
  has_many :order_products
  has_many :orders, through: :order_products

  # Order scopes

  scope :recent, -> { order(created_at: :desc) }
  scope :oldest, -> { order(created_at: :asc) }
  scope :expensive, -> { order(price: :desc) }
  scope :cheap, -> { order(price: :asc) }

  # Category scopes

  scope :main_course, -> { where(description: 'Main courses') }
  scope :second_course, -> { where(description: 'Second courses') }
  scope :entree, -> { where(description: 'Entrees') }
  scope :salad, -> { where(description: 'Salads') }
  scope :dessert, -> { where(description: 'Dessert') }

  # Default scope
  scope :default, -> { all }
end
