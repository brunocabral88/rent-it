class CreateTools < ActiveRecord::Migration[5.0]
  def change
    create_table :tools do |t|
      t.string :name
      t.string :category
      t.string :owner_id
      t.string :picture
      t.text :description
      t.float :lat
      t.float :lng
      t.integer :deposit_cents
      t.integer :daily_rate_cents
      t.boolean :availability
      t.timestamps
    end

    add_index :tools, :owner_id
  end
end
