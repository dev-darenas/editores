class CreateOrderWares < ActiveRecord::Migration[5.2]
  def change
    create_table :order_wares do |t|
      t.references :order, foreign_key: true
      t.references :ware, foreign_key: true
      t.integer :quantity, default: 0
      t.decimal :total, default: 0.0
      t.text :observations

      t.timestamps
    end
  end
end
