require "open-uri"
class HomeController < ApplicationController

  def index
    @data = URI.parse("http://127.0.0.1:3000/championships").read    
    @championships = JSON.parse(@data)
    puts @championships
    
  end

end