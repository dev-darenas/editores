class ChangeStatusColumInPayments < ActiveRecord::Migration[5.2]
  def change
    rename_column :payments, :status, :kind
    change_column :payments, :kind, :integer, default: 0
  end
end
