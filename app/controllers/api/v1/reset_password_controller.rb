class Api::V1::ResetPasswordController < ApplicationController
  # before_action :valid_user, only: %i[edit update]
  # before_action :check_expiration, only: %i[edit update]
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
    @user = User.select do |u|
      BCrypt::Password.new(u.reset_digest) == params[:id] unless u.reset_digest.nil?
    end[0]

    if @user.update(user_params)
      @user.forget
      reset_session
      log_in @user
      head :ok
    else
      render json: { message: 'Error' }, status: :bad_request
    end
  end

  private
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
