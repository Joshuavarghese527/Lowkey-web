class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :location_type
      t.integer :accomodate
      t.string :lisiting_name
      t.text :summary
      t.string :address
      t.boolean :is_internet
      t.integer :price
      t.boolean :active

      t.timestamps
    end
  end
end
