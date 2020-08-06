class AddToCartController < ApplicationController
  def add_product_to_cart
    if(logged_in?)
      logged_user = current_user
      cart = logged_user.cart
      product = Product.find(params[:id])
      cart.products << product
    else 
      flash.now[:danger] = "What kind of sorcery is this??"
    end
  end
end
