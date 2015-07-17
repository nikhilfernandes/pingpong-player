class Game < ActiveRecord::Base
  has_many :rounds
  belongs_to :player
  belongs_to :championship

  module ROLE
    OFFENSE = "offense"
    DEFENSE = "defense"
  end

  
  validates_presence_of :game_identity, :oponent_identity, :status
  

end