class CartProduct < ApplicationRecord
  default_scope { joins(:product).merge(Product.cheap) }

  belongs_to :cart
  belongs_to :product

  scope :total_sum, ->(cart_id) { where('cart_id = ?', cart_id).joins(:product).sum('price * quantity') }
  scope :no_of_products, ->(cart) { where('cart_id = ?', cart.id).sum('quantity') }
end
