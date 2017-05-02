class ChangeToolPictureTypeToPaperclip < ActiveRecord::Migration[5.0]
  def up
    remove_column :tools, :picture
    add_attachment :tools, :picture
  end

  def down
    remove_attachment :tools, :picture
    add_column :tools, :picture, :string
  end
end
