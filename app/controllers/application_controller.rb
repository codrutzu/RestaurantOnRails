class ApplicationController < ActionController::Base
  include SessionsHelper, UsersHelper

  def authorize_user!
    if !logged_in?
      flash.now[:danger] = 'You have to log in'
      redirect_to root_url
    end
  end
end
