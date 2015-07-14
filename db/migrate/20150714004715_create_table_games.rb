class CreateTableGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :identity
      t.string :oponent_identity
      t.integer :order_of_play
      t.string :role
      t.string :status
      t.integer :player_id
    end
  end
end
