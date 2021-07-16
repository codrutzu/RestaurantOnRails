class Api::V1::ResetPasswordController < ApplicationController
  before_action :get_user, only: %i[update]
  before_action :check_expiration, only: %i[update]
  skip_before_action :verify_authenticity_token

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      head :ok
    else
      render json: { message: 'Invalid email' }, status: :bad_request
    end
  end

  def update
    if @user.update(user_params)
      @user.forget
      reset_session
      log_in @user
      head :ok
    else
      render json: { message: 'Something went wrong' }, status: :bad_request
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.select do |u|
        BCrypt::Password.new(u.reset_digest) == params[:id] unless u.reset_digest.nil?
      end[0]
    end

    def check_expiration
      if @user.password_reset_expired?
        render json: { message: 'Password reset token has expired' }, status: :bad_request
      end
    end
end
