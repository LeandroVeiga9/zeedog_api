class CreateSkus < ActiveRecord::Migration[7.1]
  def change
    create_table :skus do |t|
      t.string :code, null: false, limit: 13
      t.string :name, null: false
      t.integer :stock_qty, null: false, null: false, default: 0
      t.integer :table_price_in_cents, null: false, default: 0
      t.integer :listing_price_in_cents, null: false, default: 0
      t.integer :product_id, null: false

      t.timestamps
    end
  end
end
