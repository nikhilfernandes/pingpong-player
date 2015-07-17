class Player < ActiveRecord::Base
    
  belongs_to :championship
  has_one :game

  module STATUS
    PLAYING = "playing"
    STOPPPED = "stopped"
  end

  def self.join_championship
    player_info = PlayerInfo.new(PLAYER_INFO["player"])    
    response = HttpRequest.post(Referee::HOST, Referee::PORT, "championships/#{championshipId}/players.json", player_info.payload, "")
    response_body = JSON.parse(response.body)
    if response.status == 201      
      championship = Championship.create(identity: response_body["championship"]["id"], 
        title: response_body["championship"]["title"], status: response_body["championship"]["status"], num_players_joined: response_body["championship"]["number_of_players_joined"])
      Player.create(championship_id: championship.id, auth_token: response_body["auth_token"], status: Player::STATUS::PLAYING)                  
    end
    return {status: response.status, body: response_body, championship: championship}
  end
  
end