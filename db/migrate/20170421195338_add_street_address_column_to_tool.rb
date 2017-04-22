class AddStreetAddressColumnToTool < ActiveRecord::Migration[5.0]
  def change
    add_column :tools, :street_address, :string
  end
end
