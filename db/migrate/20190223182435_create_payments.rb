class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :order, foreign_key: true
      t.decimal :total_paid
      t.date :date
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
