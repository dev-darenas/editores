class AddDueRelationToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :due, index: true
  end
end
