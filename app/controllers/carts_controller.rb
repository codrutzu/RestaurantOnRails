class CartsController < ApplicationController 
  def index
    @carts = Cart.all 
  end
  
  def show 
    user = User.find(current_user.id)
    @cart = user.cart
  end
end