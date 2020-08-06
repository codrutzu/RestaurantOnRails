class CreateCartsProductsJoinTable < ActiveRecord::Migration[6.0]
  def change

    create_join_table :carts, :products, id:false do |t|
      t.index :cart_id
      t.index :product_id
    end
  end
end
