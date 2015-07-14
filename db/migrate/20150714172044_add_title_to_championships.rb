class AddTitleToChampionships < ActiveRecord::Migration
  def change
    add_column :championships, :title, :string
  end
end
