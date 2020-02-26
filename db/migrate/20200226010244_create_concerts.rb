class CreateConcerts < ActiveRecord::Migration[6.0]
  def change
    create_table :concerts do |t|
      t.text :display
      t.text :type
      t.text :url
      t.integer :venue_id
      t.text :venue_name
      t.text :location
      t.decimal :location_lat
      t.decimal :location_long
      t.text :date
      t.text :time
      t.text :headline, array: true, default: []
      t.text :support, array: true, default: []
      t.integer :api_id

      t.timestamps
    end
  end
end
