class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :address
      t.string :city
      t.string :phone
      t.datetime :placed_at

      t.timestamps
    end
  end
end
