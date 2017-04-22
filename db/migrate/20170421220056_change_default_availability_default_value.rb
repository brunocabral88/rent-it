class ChangeDefaultAvailabilityDefaultValue < ActiveRecord::Migration[5.0]
  def change
    change_column_default :tools, :availability, true
  end
end
