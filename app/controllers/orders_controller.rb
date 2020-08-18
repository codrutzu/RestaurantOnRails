require 'rqrcode'

class OrdersController < ApplicationController
  before_action :logged_in_user, only: %i[show]
  before_action :correct_order, only: %i[show]

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.placed_at = Time.zone.now
    @order.user = current_user
    if @order.save
      add_product_from_order @order
      empty_user_cart @order.user
      redirect_to @order
    else
      flash[:danger] = 'Something went wrong! Try again.'
      redirect_to new_order_path
    end
  end

  def show
    @order = Order.find(params[:id])
    qr_code = @qr_code ||= RQRCode::QRCode.new(request.base_url + order_products_path(order: @order))
    @svg = qr_code.as_svg
  end

  private

  def order_params
    params.require(:order).permit(:address, :city, :phone)
  end
end
