class OrderProductsController < ApplicationController
  before_action :logged_in_user, only: %i[index]

  def index
    @disable_nav = true
    @order_products = OrderProduct.where(order_id: params[:order])
  end
end
