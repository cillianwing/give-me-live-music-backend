class ChangeTypeColumnInConcerts < ActiveRecord::Migration[6.0]
  def change
    rename_column :concerts, :type, :event_type
  end
end
