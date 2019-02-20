class AddObservationToLoadWare < ActiveRecord::Migration[5.2]
  def change
  	add_column :load_wares, :observations, :text
  end
end
