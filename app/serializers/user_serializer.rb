class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :cart_id, :items_count

  def cart_id
    object.cart&.id
  end

  def items_count
    object&.cart&.products&.count
  end
end
