class GamesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :validate_player!
  respond_to :json

  

  def create
    championship = Championship.find_by_identity(params[:championship_id])
    params[:game][:championship_id] = championship.id
    params[:game][:player_id] = @current_player.id
    game = championship.games.create(params[:game].permit(:game_identity, :oponent_identity, :status, :player_id))
    respond_with(game, location: "")
  end

  def update
    championship = Championship.find_by_identity(params[:championship_id])    
    game = championship.games.find_by_game_identity(params[:id]).update_attributes(params[:game].permit(:outcome, :status))
    respond_with(game, location: "")
  end

  

end