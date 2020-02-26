class CreateVenues < ActiveRecord::Migration[6.0]
  def change
    create_table :venues do |t|
      t.text :name
      t.text :city
      t.text :state
      t.text :street
      t.text :url
      t.text :description
      t.integer :api_id

      t.timestamps
    end
  end
end
