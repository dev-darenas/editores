class AddObservationToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :observations, :text
  end
end
