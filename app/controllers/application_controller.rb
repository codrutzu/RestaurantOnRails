class ApplicationController < ActionController::Base
  include UsersHelper
  include SessionsHelper
  include OrdersHelper

  def authorize_user!
    unless logged_in?
      flash.now[:danger] = 'You have to log in'
      redirect_to root_url
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
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
