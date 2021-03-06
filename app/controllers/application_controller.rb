class ApplicationController < ActionController::Base
  include ApiErrorHandling
  include UsersHelper
  include SessionsHelper
  include OrdersHelper

  def authorize_user!
    unless logged_in?
      render json: { message: 'You have to log in' }, status: 401
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      render json: { message: 'Please log in' }, status: 401
    end
  end

  def authenticate_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def authenticate_order
    order = Order.find(params[:id])
    @user = order.user
    render json: { message: 'You have no access to this order'}, status: 401 unless current_user?(@user)
  end
end
