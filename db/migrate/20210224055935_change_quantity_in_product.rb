class ChangeQuantityInProduct < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :quantity, :weight
  end
end
