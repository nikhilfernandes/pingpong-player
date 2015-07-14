require "open-uri"
class HomeController < ApplicationController

  def index
    @data = URI.parse("#{Referee::HOST}:#{Referee::PORT}/championships").read    
    @championships = JSON.parse(@data)    
    @player_info = PlayerInfo.new(PLAYER_INFO["player"])    
  end

end