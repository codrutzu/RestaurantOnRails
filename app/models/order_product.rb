class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  scope :total_sum, ->(order_id) { where('order_id = ?', order_id).sum('price * quantity') }
end
