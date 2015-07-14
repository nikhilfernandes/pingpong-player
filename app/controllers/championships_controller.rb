class ChampionshipsController < ApplicationController

  def create
    player_info = PlayerInfo.new(PLAYER_INFO["player"])    
    championshipId = params[:championshipId]
    data = {player: {identity: player_info.identity, name: player_info.name , 
      defence_length: player_info.defence_set_length, host: player_info.host , port: player_info.port , path: player_info.path}}        
    response = HttpRequest.post("http://127.0.0.1", "3000", "championships/#{championshipId}/players.json", data, "")
    if response.status == 201
      render json: {success: true}, status: :created      
    elsif response.status == 422
      render json: JSON.parse(response.body), status: :unprocessable_entity      
    else
      render json: {error: true}, status: :error      
    end
    
  end

  def show

  end
end