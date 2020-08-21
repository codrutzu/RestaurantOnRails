class HomePageController < ApplicationController
  before_action :redirect, only: :index

  def index
    @products = Product.all
    if !params[:order].nil?
      @products = @products.send(scope(params[:order]))
    end
    if !params[:category].nil?
      @products = @products.send(scope(params[:category]))
    end
    @products = @products.paginate(page: params[:page], per_page: 12)
  end

  private

    def redirect
      if current_user&.admin? && params[:preview].nil?
        redirect_to admin_path
      else
        true
      end
    end

    def scope(filter)
      scopes = %w(recent oldest expensive cheap main_course second_course entree salad dessert)
      scopes.include?(filter) ? filter : 'default'
    end
end
