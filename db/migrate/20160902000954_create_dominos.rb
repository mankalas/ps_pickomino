class CreateDominos < ActiveRecord::Migration[5.0]
  def change
    create_table :dominos do |t|
      t.integer :value
      t.integer :nb_worms

      t.timestamps
    end
  end
end
