class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
  end
  helper_method :current_user

  def set_character_name
    @character_name  = character.name
  end

  def current_character
	@current_character ||= Character.find(current_user.profile.character_id) if current_user && current_user.profile.character_id
  end
  helper_method :current_character
  
  
  def authorize
	redirect_to login_path unless current_user
  end

  def authorize(user)
    redirect_to root_path unless current_user == user
  end

  def max_num_characters
	@max_num_characters = 10
  end
  helper_method :max_num_characters
  
  private
  def find_character
    @charater = Comment.find(params[:character_id])
  end
end
