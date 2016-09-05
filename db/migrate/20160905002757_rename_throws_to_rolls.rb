class RenameThrowsToRolls < ActiveRecord::Migration[5.0]
  def change
    rename_table :throws, :rolls
  end
end
