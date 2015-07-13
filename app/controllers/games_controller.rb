class GamesController < ApplicationController
  respond_to :json

  def create
    game = current_player.games.create(params[:game].permit(:identity, :oponent, :order_of_play, :role))
    respond_with(game, location: "")
  end

  def update
    game = current_player.games.find(params[:id]).update_attributes(params[:game].permit(:order_of_play, :role))
    respond_with(game, location: "")
  end

end