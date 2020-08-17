class HomePageController < ApplicationController
  before_action :redirect, only: :index

  def index
    @products = Product.paginate(page: params[:page], per_page: 12)
  end
end
