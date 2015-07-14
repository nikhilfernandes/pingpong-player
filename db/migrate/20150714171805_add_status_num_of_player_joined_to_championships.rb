class AddStatusNumOfPlayerJoinedToChampionships < ActiveRecord::Migration
  def change
    add_column :championships, :status, :string
    add_column :championships, :num_players_joined, :integer
  end
end
