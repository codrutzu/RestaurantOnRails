class OrderProductsController < ApplicationController
  def index
    @disable_nav = true
    @order_products = OrderProduct.where(order_id: params[:order])
  end
end
