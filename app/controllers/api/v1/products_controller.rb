
class Api::V1::ProductsController < ApplicationController
  include Rails.application.routes.url_helpers

  def index
    products = Product.all

    render json: products, each_serializer: ProductSerializer
  end
end
