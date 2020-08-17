class CartsController < ApplicationController
  before_action :logged_in_user, only: :show

  def index
    @carts = Cart.all
  end

  def show
    @cart = current_user.cart
  end
end
