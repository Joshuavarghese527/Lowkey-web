class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.references :location, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :price
      t.string :integer
      t.integer :total

      t.timestamps
    end
  end
end
