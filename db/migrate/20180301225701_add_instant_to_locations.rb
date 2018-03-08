class AddInstantToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :instant, :integer, default: 1
  end
end
