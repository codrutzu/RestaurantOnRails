class ProductSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :description, :price, :image

  def image
    object.image.url unless object.image.nil?
  end
end
