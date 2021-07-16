
class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.activated?
        reset_session
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        session[:session_token] = user.session_token
        head :ok
      else
        render json: { message: 'Account is not activated yet' }, status: :bad_request
      end
    else
      render json: { message: 'Invalid username or password' }, status: :bad_request
    end
  end

  def destroy
    log_out if logged_in?

    head :ok
  end
end
