class CartsController < ApplicationController 
  def index
    @carts = Cart.all 
  end
  
  def show 
    @cart = current_user.cart
  end
end