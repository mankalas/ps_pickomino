class CreateTurns < ActiveRecord::Migration[5.0]
  def change
    create_table :turns do |t|
      t.references :game, foreign_key: true
      t.references :player, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
