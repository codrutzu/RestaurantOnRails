class PasswordResetsController < ApplicationController
  before_action :get_user, only: %i[edit update]
  before_action :valid_user, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = 'Email sent with password reset instructions'
      redirect_to root_url
    else
      flash.now[:danger] = 'Email adress not found'
      render 'new'
    end
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, 'cannot be empty')
      render 'edit'
    elsif @user.update(user_params)
      @user.forget
      reset_session
      log_in @user
      flash[:succes] = 'Password has been reset.'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit; end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    redirect_to root_url unless @user&.activated? && @user&.authenticated?(:reset, params[:id])
  end

  def check_expiration
    if @user.password_reset_expired?
      render json: { message: 'Password reset token has expired' }, status: :bad_request
    end
  end
end
