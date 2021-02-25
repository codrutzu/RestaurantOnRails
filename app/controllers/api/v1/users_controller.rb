
class Api::V1::UsersController < ApplicationController
  before_action :authorize_user!, only: :show
  skip_before_action :verify_authenticity_token

  def show
    render json: current_user, serializer: UserSerializer
  end
end

