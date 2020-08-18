class OrderProductsController < ApplicationController
  before_action :logged_in_user, only: %i[index]
  before_action :correct_user_for_order, only: :index

  def index
    @disable_nav = true
    @order_products = OrderProduct.where(order_id: params[:order])
  end

  def correct_user_for_order
    @order = Order.find(params[:order])
    @user = @order.user
    redirect_to(root_url) unless current_user?(@user)
  end
end
