class CartProductsController < ApplicationController
  before_action :authorize_user!, only: :create

  def create
    cart = current_user.cart
    if (cart_product = CartProduct.find_by(product_id: params[:id], cart_id: params[:cart]))
      cart_product.update_columns(quantity: cart_product.quantity + 1)
    else
      cart.products << Product.find(params[:id])
    end
    if !params[:id].nil? && params[:route] == 'cart'
      redirect_to cart_path(cart)
    elsif !params[:preview].nil?
      redirect_to root_url(preview: params[:preview])
    else
      redirect_to root_url
    end
  end

  def destroy
    cart_product = CartProduct.find_by(product_id: params[:id], cart_id: params[:cart])
    if cart_product.quantity > 1
      cart_product.update_columns(quantity: cart_product.quantity - 1)
    else
      CartProduct.delete(cart_product)
    end
    redirect_to cart_path(current_user.cart)
  end
end
