class CreateToolsDictionaries < ActiveRecord::Migration[5.0]
  def change
    create_table :tools_dictionaries do |t|
      t.string :name
      t.timestamps
    end
  end
end
