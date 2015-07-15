class Player < ActiveRecord::Base
  
  has_many :games
  belongs_to :championship

  module STATUS
    PLAYING = "playing"
    STOPPPED = "stopped"
  end
  
end