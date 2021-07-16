class OrderProductsController < ApplicationController
  before_action :check_authenticated_order, only: :index

  def index
    @disable_nav = true
    @order_products = OrderProduct.where(order_id: params[:order])
    @order = @order_products.first.order
  end

  def check_authenticated_order
    @order = Order.find(params[:order])
    redirect_to(root_url) unless @order.authenticated?(params[:token])
  end
end
