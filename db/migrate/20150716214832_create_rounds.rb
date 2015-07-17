class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :game_id
      t.string :round_identity
      t.string :role
      t.integer :order_of_play
      t.string :outcome      
    end
  end
end
    