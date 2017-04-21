class DropColumnsInReview < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :comments
    remove_column :reviews, :rental_id
    add_column :reviews, :comment, :text
  end
end
