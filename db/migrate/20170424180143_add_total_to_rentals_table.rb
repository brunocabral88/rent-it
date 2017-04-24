class AddTotalToRentalsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :total_cents, :integer
  end
end
