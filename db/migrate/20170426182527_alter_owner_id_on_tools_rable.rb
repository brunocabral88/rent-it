class AlterOwnerIdOnToolsRable < ActiveRecord::Migration[5.0]
  def up
    change_column :tools, :owner_id, 'integer USING CAST(owner_id AS integer)'
  end
  def down
    change_column :tools, :owner_id, :string, index: true
  end
end
