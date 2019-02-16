class CreateLoadWares < ActiveRecord::Migration[5.2]
  def change
    create_table :load_wares do |t|
      t.references :user, foreign_key: true
      t.references :ware, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
