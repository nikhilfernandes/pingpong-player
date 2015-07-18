class Round <  ActiveRecord::Base
  belongs_to :game
  validates_presence_of :round_identity, :role, :order_of_play
  validates_numericality_of :order_of_play

  def play_params(value)
    player_info = PlayerInfo.new(PLAYER_INFO["player"])
    if self.role == Game::ROLE::OFFENSE
      {offensive_number: value}
    elsif self.role == Game::ROLE::DEFENSE
      {defensive_array: value}
    end
    
  end

  def play(value, player_auth)
    player_info = PlayerInfo.new(PLAYER_INFO["player"])
    params = {round: {last_played_by: player_info.identity}.merge!(play_params(value))}
    response = HttpRequest.put(Referee::HOST,Referee::PORT, "/championships/#{self.game.championship.identity}/games/#{game.game_identity}/rounds/#{round_identity}", params, player_auth)    
    if response.status == 200      
      return {status: 200}
    elsif response.status == 422
      return {status: 422, body: JSON.parse(response.body)}
    else
      return {error: true}
    end
  end
end