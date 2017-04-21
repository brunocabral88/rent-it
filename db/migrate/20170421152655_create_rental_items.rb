class CreateRentalItems < ActiveRecord::Migration[5.0]
  def change
    create_table :rental_items do |t|
      t.integer :rental_id
      t.integer :tool_id

      t.timestamps
    end
  end
end
