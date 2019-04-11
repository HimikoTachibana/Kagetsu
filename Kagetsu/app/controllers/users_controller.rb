class UsersController < ApplicationController
	layout "userform", except: [:index, :show]

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_path
		else
			flash.now[:alert] = "There was a problem creating your account."
			render "new"
		end
	end

	def set_default_character
		@user = User.find(current_user)
		@user.profile.update_attribute(:character_id, params[:character_id])
		@character = current_character
		respond_to do |format|
			format.js
		end
	end

	def preview
		@user = User.find(params[:user_id])
		respond_to do |format|
			format.html
			format.js
		end
	end

private
	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation, :profile_id)
	end
end
