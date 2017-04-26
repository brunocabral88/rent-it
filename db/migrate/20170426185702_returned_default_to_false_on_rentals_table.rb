class ReturnedDefaultToFalseOnRentalsTable < ActiveRecord::Migration[5.0]
  def change
    change_column :rentals, :returned, :boolean, default: false
  end
end
