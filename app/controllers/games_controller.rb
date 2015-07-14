class GamesController < ApplicationController
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
    render json: {result: @current_player.games.find(params[:id]).play}
  end

  def validate_player!        
    auth_token = request.headers["HTTP_X_AUTHENTICATION_TOKEN"]
    @current_player = auth_token && Player.where(auth_token: auth_token).first 
    unless @current_player
      render json: {errors: {message: "You are not authorized to perform this operation.", auth_token: auth_token }}, status: :unauthorized
      return
    end                        
  end

end