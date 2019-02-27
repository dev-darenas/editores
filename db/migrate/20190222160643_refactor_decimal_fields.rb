class RefactorDecimalFields < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :quota_amount, :decimal, precision: 13, scale: 2
    change_column :orders, :total_paid, :decimal, precision: 13, scale: 2
    change_column :orders, :latitude, :decimal, precision: 10, scale: 6 
    change_column :orders, :longitude, :decimal, precision: 10, scale: 6
    change_column :orders_wares, :total, :decimal, precision: 13, scale: 2
    change_column :wares, :price, :decimal, precision: 13, scale: 2
  end
end
