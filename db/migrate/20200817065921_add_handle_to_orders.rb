class AddHandleToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :handled, :boolean, default: false
  end
end
