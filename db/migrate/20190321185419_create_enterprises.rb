class CreateEnterprises < ActiveRecord::Migration[5.2]
  def change
    create_table :enterprises do |t|
      t.string :name
      t.text :description
      t.references :country, foreign_key: true

      t.timestamps
    end
  end
end
