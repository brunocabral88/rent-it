class AddColumnToTools < ActiveRecord::Migration[5.0]
  def change
    add_column :tools, :city, :string
    add_column :tools, :province, :string
  end
end
