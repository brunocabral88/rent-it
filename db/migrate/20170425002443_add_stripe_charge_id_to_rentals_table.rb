class AddStripeChargeIdToRentalsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :stripe_charge_id, :integer
  end
end
