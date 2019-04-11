class SessionsController < ApplicationController
  layout "userform"

  def new
  end

  def create
	@user = User.authenticate(params[:username], params[:password])

	if @user
	  session[:user_id] = @user.id
	  redirect_to root_path
	else
	  flash.now[:alert] = "Invalid username/password"
	  render "new"
	end

  end

  def destroy
	session[:user_id] = nil
  	redirect_to root_path
  end
end
