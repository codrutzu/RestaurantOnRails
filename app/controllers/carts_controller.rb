class CartsController < ApplicationController 
  def index
    @carts = Cart.all 
  end
  
  def show 
    logged_user = current_user
    user = User.find(logged_user.id)
    @cart = user.cart
  end
end