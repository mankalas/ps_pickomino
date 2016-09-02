class CreateInGameDominos < ActiveRecord::Migration[5.0]
  def change
    create_table :in_game_dominos do |t|
      t.boolean :available
      t.references :game, foreign_key: true
      t.references :player, foreign_key: true
      t.references :domino, foreign_key: true

      t.timestamps
    end
  end
end
