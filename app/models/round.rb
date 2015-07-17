class Round <  ActiveRecord::Base
  belongs_to :game
  validates_presence_of :round_identity, :role, :order_of_play
  validates_numericality_of :order_of_play

  def play(value)
    player_info = PlayerInfo.new(PLAYER_INFO["player"])
    if self.role == ROLE::OFFENSE
      {offensive_number: value}
    elsif self.role == ROLE::DEFENSE
      {defensive_array: value}
    end
    
  end

  def play(value, player_auth)
    player_info = PlayerInfo.new(PLAYER_INFO["player"])
    params = {round: {last_played_by: player_info.identity}.merge!(play(value))}
    response = HttpRequest.post(Referee::HOST,Referee::PORT, "/championships/#{self.game.championship.identity}/games/#{game.identity}/rounds/#{round_identity}", params, player_auth)    
    if response.status == 200      
      render json: {success: true}, status: :ok      
    elsif response.status == 422
      render json: JSON.parse(response.body), status: :unprocessable_entity      
    else
      render json: {error: true}, status: :error      
    end
  end
end