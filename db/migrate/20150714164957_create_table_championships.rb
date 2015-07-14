class CreateTableChampionships < ActiveRecord::Migration
  def change
    create_table :championships do |t|
      t.string :identity
      
      
    end
  end
end
