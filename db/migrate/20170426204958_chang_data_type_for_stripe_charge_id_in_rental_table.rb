class ChangDataTypeForStripeChargeIdInRentalTable < ActiveRecord::Migration[5.0]
  def change
    change_column :rentals, :stripe_charge_id, :string

  end
end
