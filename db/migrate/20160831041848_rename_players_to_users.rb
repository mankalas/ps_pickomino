class RenamePlayersToUsers < ActiveRecord::Migration[5.0]
  def change
    rename_table :players, :users
    rename_table :games_players, :games_users
    rename_column :games_users, :player_id, :user_id
  end
end
