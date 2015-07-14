class GamesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :validate_player!
  respond_to :json

  def create
    game = @current_player.games.create(params[:game].permit(:identity, :oponent_identity, :order_of_play, :role, :status))
    respond_with(game, location: "")
  end

  def update
    game = @current_player.games.find(params[:id]).update_attributes(params[:game].permit(:order_of_play, :role, :status))
    respond_with(game, location: "")
  end

  def play
    game = @current_player.games.find(params[:id])
    player_info = PlayerInfo.new(PLAYER_INFO["player"])
    params = {round: {turn: player_info.identity}.merge!(game.play)}
    HttpRequest.post("http://localhost",3000, "/championships/#{game.championship_id}/games/#{game.identity}/rounds", params, @current_player.auth_token)    
    render json: {message: "Player has played."}, status: :ok
  end

  

end