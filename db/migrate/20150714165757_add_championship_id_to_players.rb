class AddChampionshipIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :championship_id, :integer
  end
end
