class OrderSerializer < ActiveModel::Serializer
  attributes :address,
             :city,
             :phone
end
