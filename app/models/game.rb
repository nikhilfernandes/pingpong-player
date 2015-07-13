class Game < ActiveRecord::Base

  module ROLE
    OFFENSE = "offense"
    DEFENSE = "defense"
  end

  belongs_to :player

  def play
    if self.role == ROLE::OFFENSE
      Random.rand(10)
    elsif self.role == ROLE::DEFENSE
      []
    end
    # post to referee app
  end

end