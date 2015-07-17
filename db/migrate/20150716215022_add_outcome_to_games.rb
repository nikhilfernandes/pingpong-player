class AddOutcomeToGames < ActiveRecord::Migration
  def change
    add_column :games, :outcome, :string
  end
end
