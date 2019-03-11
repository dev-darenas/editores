class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true
      t.datetime :date
      t.decimal :latitude, precision: 10, scale: 6 
      t.decimal :longitude, precision: 10, scale: 6 

      t.timestamps
    end
  end
end
