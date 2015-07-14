class AddAuthTokenToPlayers < ActiveRecord::Migration
  def change
    create_table(:players) do |t|
      t.string :auth_token      
    end
    
  end
end
