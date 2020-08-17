class HomePageController < ApplicationController
  before_action :redirect, only: :index

  def index
    @products = Product.paginate(page: params[:page], per_page: 12)
  end

  private

  def redirect
    if current_user&.admin? && params[:preview].nil?
      redirect_to admin_path
    else
      true
    end
  end
end
