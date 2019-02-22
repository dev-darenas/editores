class RenameOrderWaresTableToOrdersWaresTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :order_wares, :orders_wares
  end
end
