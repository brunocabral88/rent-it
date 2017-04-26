class AddStripeCustomerIdAndStripeSourceIdToRentalsTable < ActiveRecord::Migration[5.0]
  def change

    remove_column :rentals, :customer, :boolean
    remove_column :rentals, :source_id, :boolean
    add_column :rentals, :stripe_customer_id, :string
    add_column :rentals, :stripe_card_id, :string
  end
end
