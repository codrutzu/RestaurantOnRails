
class Api::V1::UsersController < ApplicationController
  before_action :authorize_user!, only: :show
  skip_before_action :verify_authenticity_token

  def show
    render json: current_user, serializer: UserSerializer
  end

  def create
    byebug
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      render json: @user
    else
      render json: { message: 'Invalid data' }, status: :bad_request
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
