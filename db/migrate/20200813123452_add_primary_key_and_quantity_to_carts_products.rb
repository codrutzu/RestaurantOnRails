class AddPrimaryKeyAndQuantityToCartsProducts < ActiveRecord::Migration[6.0]
  def change
    rename_table 'carts_products', 'cart_products'
    add_column :cart_products, :id, :primary_key
    add_column :cart_products, :quantity, :integer, default: 1
  end
end
