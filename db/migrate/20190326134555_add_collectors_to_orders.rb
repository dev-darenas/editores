class AddCollectorsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :collector, index: true
    add_foreign_key :orders, :users, column: :collector_id, primary_key: :id
  end
end
