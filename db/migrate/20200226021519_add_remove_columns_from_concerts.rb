class AddRemoveColumnsFromConcerts < ActiveRecord::Migration[6.0]
  def change
    remove_column :concerts, :location_lat, :decimal
    remove_column :concerts, :location_long, :decimal
    remove_column :concerts, :location, :text 
    add_column :concerts, :city, :text 
    add_column :concerts, :state, :text
  end
end
