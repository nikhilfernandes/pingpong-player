class AddChampionshipIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :championship_id, :integer
  end
end
