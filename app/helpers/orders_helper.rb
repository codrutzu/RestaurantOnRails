module OrdersHelper
  def add_product_from_order(order)
    CartProduct.where(cart_id: order.user.cart.id).each do |cart_product|
      product = Product.find(cart_product.product_id)
      order.products << product
      order_product = OrderProduct.find_by(order_id: order.id, product_id: product.id)
      order_product.update_columns(quantity: cart_product.quantity, price: product.price)
    end
  end

  def empty_user_cart(user)
    CartProduct.where(cart_id: user.cart.id).delete_all
  end
end
