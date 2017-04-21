class DropRentalColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :rentals, :tool_id
    remove_column :rentals, :rating
    remove_column :rentals, :comment
    remove_column :rentals, :stripe_charge_id
  end
end
