class AddToCartController < ApplicationController
  before_action :authorize_user!, only: :create

  def create
      cart = current_user.cart
      cart.products << Product.find(params[:id])
      redirect_to root_url
  end
end
