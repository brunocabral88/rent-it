class CreateRentals < ActiveRecord::Migration[5.0]
  def change
    create_table :rentals do |t|
      t.integer :renter_id
      t.string :tool_id
      t.date :start_date
      t.date :end_date
      t.integer :rating
      t.text :comment
      t.string :stripe_charge_id

      t.timestamps
    end
    add_index :rentals, :renter_id
  end
end
