class AddPriceToOrderProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :order_products, :price, :decimal
  end
end
