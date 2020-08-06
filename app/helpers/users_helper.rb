module UsersHelper
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  def create_cart_for_user(user)
    cart = Cart.new
    user.cart = cart
  end
end
