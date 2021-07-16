class CartProductSerializer < ActiveModel::Serializer
  attributes :id, :cart_id, :product_id, :product_name, :quantity, :price, :product_image, :weight

  def product_name
    Product.find(object.product_id).title
  end

  def weight
    Product.find(object.product_id).weight
  end

  def product_image
    Product.find(object.product_id).image.url unless Product.find(object.product_id).image.nil?
  end

  def price
    Product.find(object.product_id).price * object.quantity
  end
end
