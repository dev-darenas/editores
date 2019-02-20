class CreateInventoryTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :inventory_transfers do |t|
      t.references :sender
      t.references :recipient
      t.date :date
      t.references :ware, foreign_key: true
      t.integer :quantity
      t.text :observations

      t.timestamps
    end
    add_foreign_key :inventory_transfers, :users, column: :sender_id, primary_key: :id
    add_foreign_key :inventory_transfers, :users, column: :recipient_id, primary_key: :id
  end
end
