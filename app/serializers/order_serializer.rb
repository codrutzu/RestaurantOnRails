class OrderSerializer < ActiveModel::Serializer
  attributes :id,
             :address,
             :city,
             :phone
end
