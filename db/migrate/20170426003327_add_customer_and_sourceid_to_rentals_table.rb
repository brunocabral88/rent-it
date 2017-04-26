class AddCustomerAndSourceidToRentalsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :customer, :boolean
    add_column :rentals, :source_id, :boolean
  end
end
