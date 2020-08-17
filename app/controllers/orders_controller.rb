require 'rqrcode'

class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.placed_at = Time.zone.now
    @order.user = current_user
    if @order.save
      redirect_to @order
    else
      flash[:danger] = 'Something went wrong! Try again.'
      redirect_to new_order_path
    end
  end

  def show
    @order = Order.find(params[:id])
    qr_code = @qr_code ||= RQRCode::QRCode.new(request.base_url + '')
    @svg = qr_code.as_svg
  end

  private

  def order_params
    params.require(:order).permit(:address, :city, :phone)
  end
end
