class RoundsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :validate_player!, :only => [:play]
  
  respond_to :json


  def create
    championship = Championship.find_by_identity(params[:championship_id])    
    game = championship.games.find_by_game_identity(params[:game_id])
    round = game.rounds.create(params[:round].permit(:round_identity, :role, :order_of_play))
    respond_with(round, location: "")
  end

  def update
    championship = Championship.find_by_identity(params[:championship_id])    
    game = championship.games.find_by_game_identity(params[:game_id])
    round = game.rounds.find_by_round_identity(params[:id]).update_attributes(params[:round].permit(:outcome, :role))
    respond_with(round, location: "")
  end

  def play    
    player_info = PlayerInfo.new(PLAYER_INFO["player"])
    championship = Championship.find(params[:championship_id])    
    game = championship.games.find(params[:game_id])
    round = game.rounds.find(params[:id])
    response = round.play(params[:value], championship.player.auth_token)
    if response[:status] == 200      
      render json: {success: true}, status: :ok      
    elsif response[:status] == 422
      render json: JSON.parse(response[:body]), status: :unprocessable_entity      
    else
      render json: {error: true}, status: :error      
    end
    
  end


end