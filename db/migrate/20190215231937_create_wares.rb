class CreateWares < ActiveRecord::Migration[5.2]
  def change
    create_table :wares do |t|
      t.string :reference
      t.string :name
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
