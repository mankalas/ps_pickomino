class RenamePlayersToUsers < ActiveRecord::Migration[5.0]
  def change
    rename_table :players, :users
    rename_table :games_players, :players
    rename_column :players, :player_id, :user_id
  end
end
