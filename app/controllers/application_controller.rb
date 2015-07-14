class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def validate_player!            
    auth_token = request.headers["HTTP_X_AUTHENTICATION_TOKEN"]
    puts auth_token
    @current_player = auth_token && Player.where(auth_token: auth_token).first 
    unless @current_player
      render json: {errors: {message: "You are not authorized to perform this operation.", auth_token: auth_token }}, status: :unauthorized
      return
    end                        
  end
  
end
