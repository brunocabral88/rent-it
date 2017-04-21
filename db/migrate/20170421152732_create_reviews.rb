class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comments
      t.integer :rental_item_id

      t.timestamps
    end
  end
end
