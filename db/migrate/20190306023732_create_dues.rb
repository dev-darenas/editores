class CreateDues < ActiveRecord::Migration[5.2]
  def change
    create_table :dues do |t|
      t.string :name
      t.integer :periodicity
      t.decimal :interests

      t.timestamps
    end
  end
end
