class Game < ActiveRecord::Base

  module ROLE
    OFFENSE = "offense"
    DEFENSE = "defense"
  end

  belongs_to :player
  validates_presence_of :identity, :oponent_identity, :status, :order_of_play, :role
  validates_numericality_of :order_of_play

  def play
    player_info = PlayerInfo.new(PLAYER_INFO["player"])
    if self.role == ROLE::OFFENSE
      {offensive_number: Random.rand(10)}
    elsif self.role == ROLE::DEFENSE
      {defensive_array: (1..10).to_a.sample player_info.defence_set_length}
    end
    
  end

end