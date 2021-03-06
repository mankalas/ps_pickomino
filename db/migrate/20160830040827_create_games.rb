class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|

      t.timestamps
    end

    create_table :games_players do |t|
      t.belongs_to :game, index: true
      t.belongs_to :player, index: true
    end
  end
end
