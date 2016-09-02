class CreateTurns < ActiveRecord::Migration[5.0]
  def change
    create_table :turns do |t|
      t.references :game, foreign_key: true
      t.references :player, foreign_key: true
      t.references :in_game_domino, foreign_key: true
      t.integer :index

      t.timestamps
    end
  end
end
