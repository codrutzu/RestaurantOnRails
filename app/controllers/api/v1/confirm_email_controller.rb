
class Api::V1::ConfirmEmailController < ApplicationController
  def show
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:activation_token])
      user.activate
      log_in user
      create_cart_for_user user
      redirect_to :root
    end
  end
end
