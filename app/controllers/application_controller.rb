class ApplicationController < ActionController::Base
  include UsersHelper
  include SessionsHelper

  def redirect
    # if params[:preview] == 1 && current_user&.admin?
    if current_user&.admin? && params[:preview].nil?
      redirect_to admin_path
    else
      true
    end
  end

  def authorize_user!
    unless logged_in?
      flash.now[:danger] = 'You have to log in'
      redirect_to root_url
    end
  end
end
