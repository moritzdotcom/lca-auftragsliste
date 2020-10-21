class PagesController < ApplicationController
  before_action :authenticate_user

  def dashboard
    @tasks = @user.tasks
    @partner = Partner.find_by(email: @user.email)
    if @partner
      @tasks_for_user = @partner.tasks
    end
  end

  private

  def authenticate_user
    if user_signed_in?
      @user = current_user
    else
      redirect_to root_path
    end
  end
end
