class ChampionshipsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :validate_player!, only: [:update]



  def create        
    response = Player.join_championship(params[:championshipId])    
    if response[:status] == 201      
      render json: {success: true, championshipId: response[:championship]}, status: :created      
    elsif response[:status] == 422
      render json: JSON.parse(response[:body]), status: :unprocessable_entity      
    else
      render json: {error: true}, status: :error      
    end
    
  end

  def show
    if request.format == :html    
      respond_to do |format|
        format.html
        return
      end
    end
    begin
      championship = Championship.find_by_identity(params[:id])      
    rescue ActiveRecord::RecordNotFound => e
      render json: {message: "Does not exist"}, status: :not_found
      return
    end 
    render json: championship.as_json(include: [:player, :games], methods: [:num_players_joined])    
  end

  def update
    
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