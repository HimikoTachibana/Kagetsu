class FriendsController < ApplicationController
	before_action do
		authorize(user)
	end

	def index
		@user = user
		@friends = user.friends.joins(:profile).where("profiles.nickname LIKE ?", "%#{params[:search_param]}%")
		@friends = current_user.except_current_user(@friends)
	end

	def new
		@user = user
		@friends = User.joins(:profile).where("profiles.nickname LIKE ?", "%#{params[:search_param]}%")
		@friends = current_user.except_current_user(@friends)
	end

	def create
		@user = user
		@friend = user.friendships.new(friend_id: params[:friend])
		if @friend.save
			redirect_to :back
		else
			redirect_to :back, flash[:error] = "There was an error with adding the user as a friend."
		end
	end

	def destroy
		@user = user
		@friend = user.friendships.where(friend_id: params[:id]).first 
		@friend.destroy
		redirect_to user_friends_path(user)
	end

private
	def user
		User.find(params[:user_id])
	end

	def friend_params
	params.require(:friend).permit(:user_id, :friend_id)
	end
end
