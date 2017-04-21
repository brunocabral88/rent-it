class AddRentalIdColumnToReview < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :rental_id, :integer
  end
end
