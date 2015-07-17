class ModifyGamesTable < ActiveRecord::Migration
  def change
    remove_column :games, :order_of_play
    remove_column :games, :role
    remove_column :games, :round_id
  end  
end
