module UsersHelper
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  def create_cart_for_user(user)
    cart = Cart.new
    user.cart = cart
  end

  def no_of_products(product)
    user = current_user
    user.cart.products.where('id = ?', product.id).count
  end
end
