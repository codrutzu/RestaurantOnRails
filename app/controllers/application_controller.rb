class ApplicationController < ActionController::Base
  include ApiErrorHandling
  include UsersHelper
  include SessionsHelper
  include OrdersHelper

  def authorize_user!
    unless logged_in?
      render json: { message: 'You have to log in' }, status: :bad_request
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      render json: { message: 'Please log in' }, status: :bad_request
    end
  end

  def authenticate_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def authenticate_order
    order = Order.find(params[:id])
    @user = order.user
    redirect_to(root_url) unless current_user?(@user)
  end
end
