class GamesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :validate_player!
  respond_to :json

  def create
    championship = Championship.find_by_identity(params[:game][:championship_id])
    params[:game][:championship_id] = championship.id
    game = @current_player.games.create(params[:game].permit(:identity, :oponent_identity, :order_of_play, :role, :status, :championship_id))
    respond_with(game, location: "")
  end

  def update
    game = @current_player.games.find(params[:id]).update_attributes(params[:game].permit(:order_of_play, :role, :status))
    respond_with(game, location: "")
  end

  def play
    game = Game.find(params[:id])
    player_info = PlayerInfo.new(PLAYER_INFO["player"])

    params = {round: {turn: player_info.identity}.merge!(game.play(params[:number]))}
    response = HttpRequest.post(Referee::HOST,Referee::PORT, "/championships/#{game.championship_id}/games/#{game.identity}/rounds", params, @current_player.auth_token)    
    if response.status == 200
      response_body = JSON.parse(response.body)      
      render json: {success: true}, status: :ok      
    elsif response.status == 422
      render json: JSON.parse(response.body), status: :unprocessable_entity      
    else
      render json: {error: true}, status: :error      
    end
    
  end

end