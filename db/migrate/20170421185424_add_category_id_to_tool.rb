class AddCategoryIdToTool < ActiveRecord::Migration[5.0]
  def change
    remove_column :tools, :category
    add_column :tools, :category_id, :integer
  end
end
