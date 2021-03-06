class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :location, foreign_key: true
      t.references :user, foreign_key: true
      t.text :comment
      t.datetime :created_at
      t.integer :star

      t.timestamps
    end
  end
end
