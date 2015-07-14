class ChampionshipsController < ApplicationController

  def create
    player_info = PlayerInfo.new(PLAYER_INFO["player"])    
    championshipId = params[:championshipId]
    data = {player: {identity: player_info.identity, name: player_info.name , 
      defence_length: player_info.defence_set_length, host: player_info.host , port: player_info.port , path: player_info.path}}        
    response = HttpRequest.post("http://127.0.0.1", "3000", "championships/#{championshipId}/players.json", data, "")
    if response.status == 201
      response_body = JSON.parse(response.body)
      championship = Championship.create(identity: response_body["championship"]["id"])
      Player.create(championship_id: championship.id, auth_token: response_body["auth_token"])
      render json: {success: true, championshipId: championship.identity}, status: :created      
    elsif response.status == 422
      render json: JSON.parse(response.body), status: :unprocessable_entity      
    else
      render json: {error: true}, status: :error      
    end
    
  end

  def show
    @championship = Championship.find_by_identity(params[:id])

  end
end