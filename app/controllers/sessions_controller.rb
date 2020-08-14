class SessionsController < ApplicationController

  def new
    @disable_nav = true
    @disable_footer = true
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.activated?
        forwarding_url = session[:forwarding_url]
        reset_session
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        session[:session_token] = user.session_token
        redirect_to forwarding_url || root_url
      else
        message = 'Account not activated.'
        message += 'Check your email for the activation link.'
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash[:danger] = 'Invalid email/password combination'
      redirect_to login_path
    end
  end

  def destroy
    log_out if logged_in?
    if !params[:switch].nil? && params[:switch] == '1'
      redirect_to login_path
    else
      redirect_to root_url
    end
  end
end
