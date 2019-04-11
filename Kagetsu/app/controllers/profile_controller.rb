class ProfileController < ApplicationController
  before_action do
	authorize(user)
  end

  def edit
    @user = user
    @profile = user.profile
  end

  def update
	@user = user
	@profile = user.profile
	if @profile.update_attributes(profile_params)
		redirect_to user_path(@user)
	else
		render 'edit'
	end
  end

private
  def profile_params
    params.require(:profile).permit(:image, :remove_image, :nickname, :dob, :is_dob_public, :gender, :is_gender_public, :comment)
  end

  def user
	User.find(params[:user_id])
  end
end
