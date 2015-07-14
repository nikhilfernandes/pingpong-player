class ChampionshipsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :validate_player!, only: [:update]


  def create
    player_info = PlayerInfo.new(PLAYER_INFO["player"])    
    championshipId = params[:championshipId]
    data = {player: {identity: player_info.identity, name: player_info.name , 
      defence_length: player_info.defence_set_length, host: player_info.host , port: player_info.port , path: player_info.path}}        
    response = HttpRequest.post(Referee::HOST, Referee::PORT, "championships/#{championshipId}/players.json", data, "")
    if response.status == 201
      response_body = JSON.parse(response.body)
      championship = Championship.create(identity: response_body["championship"]["id"], 
        title: response_body["championship"]["title"], status: response_body["championship"]["status"], num_players_joined: response_body["championship"]["number_of_players_joined"])
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

  def update
    if @curent_player.nil?
      render json:  {error: true}, status: :unauthorized      
      return
    end
    championship = Championship.find_by_identity(params[:id])    
    championship.update_attributes(params.require(:championship).permit(:status, :num_players_joined))
    if championship.valid?
      render json: championship, status: :ok
      return
    else
      render json: { :errors => championship.errors.full_messages }, status: :unprocessable_entity      
      return
    end
  end
end