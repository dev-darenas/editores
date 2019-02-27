class AddCoordinatesToPaymentTable < ActiveRecord::Migration[5.2]
  def change
    change_column :payments, :total_paid, :decimal, precision: 13, scale: 2
    add_column :payments, :latitude, :decimal, precision: 10, scale: 6 
    add_column :payments, :longitude, :decimal, precision: 10, scale: 6
  end
end
