class CreateThrows < ActiveRecord::Migration[5.0]
  def change
    create_table :throws do |t|
      t.references :turn, foreign_key: true
      t.string :outcome
      t.string :pick

      t.timestamps
    end
  end
end
