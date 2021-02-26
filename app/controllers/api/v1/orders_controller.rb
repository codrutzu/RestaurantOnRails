require 'rqrcode'

class Api::V1::OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :logged_in_user, only: %i[show create]
  before_action :authenticate_order, only: %i[show]
  before_action :products_in_cart, only: :create

  def create
    @order = Order.new(order_params)
    @order.placed_at = Time.zone.now
    @order.user = current_user
    if @order.save
      add_product_from_order @order
      delete_user_order @order.user
      render json: @order.id
    end
  end

  def show
    order = Order.find(params[:id])
    order.regenerate_order_token
    qr_code = @qr_code ||= RQRCode::QRCode.new(request.base_url + order_products_path(order: order, token: order.order_token))

    render json: qr_code.as_svg.html_safe
  end

  private

    def order_params
      params.require(:order).permit(:address, :city, :phone)
    end

    def products_in_cart
      redirect_to root_url unless current_user.cart.products.count != 0
    end
end
