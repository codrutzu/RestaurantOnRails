require 'rqrcode'

class Order < ApplicationRecord
  validates :address, presence: true
  validates :city, presence: true
  validates :phone, presence: true
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products

  scope :order_count, ->(user_id, handled) { where('user_id = ?', user_id).where('handled = ?', handled).count }
end
