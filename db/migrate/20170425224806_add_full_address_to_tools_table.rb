class AddFullAddressToToolsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :tools, :full_address, :string
  end
end
