class AddToCartController < ApplicationController
  def add_product_to_cart
    if(logged_in?)
      cart = current_user.cart
      cart.products << Product.find(params[:id])
    else 
      flash.now[:danger] = "What kind of sorcery is this??"
    end
  end
end
