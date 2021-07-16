
class Api::V1::ConfirmEmailController < ApplicationController
  def show
    user = User.select { |u| BCrypt::Password.new(u.activation_digest) == params[:activation_token] }[0]
    unless user.nil?
      user.activate
      log_in user
      create_cart_for_user user
      redirect_to :root
    else
      redirect_to :root
    end
  end
end
