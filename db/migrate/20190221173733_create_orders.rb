class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :code
      t.references :department, foreign_key: true
      t.references :city, foreign_key: true
      t.date :date
      t.string :client_name
      t.string :client_phone
      t.string :spouse_name
      t.string :spouse_phone
      t.string :address_one
      t.string :neighborhood_address_one
      t.string :address_two
      t.string :neighborhood_address_two
      t.string :familiar_reference
      t.string :familiar_reference_phone
      t.string :personal_reference
      t.string :personal_reference_phone
      t.date :payment_date
      t.text :observations
      t.integer :quota_quantity, default: 0
      t.decimal :quota_amount, default: 0.0
      t.decimal :total_paid, default: 0.0
      t.decimal :latitude, default: 0.0
      t.decimal :longitude, default: 0.0

      t.timestamps
    end
  end
end
