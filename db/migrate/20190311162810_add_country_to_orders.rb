class AddCountryToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :country, index: true
  end
end
