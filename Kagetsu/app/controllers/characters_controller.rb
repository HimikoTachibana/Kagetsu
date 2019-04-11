class CharactersController < ApplicationController
  before_action :except => [:index, :show] do
	authorize(user)
  end
  
  def show
	@user = user
	@character = user.characters.find(params[:id])
  end

  def new
	@user = user
	@character = user.characters.new
  end

  def edit
	@user = user
	@character = user.characters.find(params[:id])
  end

  def create
	@user = user
	if @user.characters.length < max_num_characters
		@character = user.characters.new(character_params)
		if @character.save
			if @user.profile.character == nil
				@user.profile.update_attribute(:character_id, @character.id)
			end
			redirect_to user_character_path(@user, @character)
		else
			render 'new'
		end
	else
	  flash[:alert] = "You are not allowed to create more than #{max_num_characters} characters."
	  redirect_to user_path(user)
	end
  end

  def update
	@user = user
	@character = user.characters.find(params[:id])
	if @character.update_attributes(character_params)
		redirect_to user_character_path(@user, @character)
	else
		render 'edit'
	end
  end

  def destroy
	@user = user
	@character = user.characters.find(params[:id])
	if @user.profile.character == @character
		@new_character = user.characters.where("id != ?", params[:id]).first
		if @new_character != nil
			@user.profile.update_attribute(:character_id, @new_character.id)
		else
			@user.profile.update_attribute(:character_id, nil)
		end
	end
	@character.destroy
	redirect_to user_path(user)
  end
	
	def set_character_name
		@comment = comment
		@character_name = comment.character.name
	end
private
  def character_params
	params.require(:character).permit(:image, :remove_image, :name, :race, :skill, :physical, :magical, :special, :biography, :psycological)
  end
	
  def user
	User.find(params[:user_id])
  end
  
  
end
