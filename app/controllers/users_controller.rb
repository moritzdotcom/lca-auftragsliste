class UsersController < ApplicationController
  def show
  end

  def edit_profile
  end

  def update_profile
    @user.update(user_profile_params)

    redirect_to @user
  end

  protected

  def user_profile_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :mobile_phone, :profile_picture)
  end
end
