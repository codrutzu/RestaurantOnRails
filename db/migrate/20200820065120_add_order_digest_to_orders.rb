class AddOrderDigestToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :order_token, :string
  end
end
