class PagesController < ApplicationController
  before_action :authenticate_user
  before_action :set_user_tasks, only: [:dashboard]

  def dashboard
  end

  def edit_settings
  end

  def update_settings
    if @user.update(settings_params)
      redirect_to edit_settings_path, notice: 'Einstellungen gespeichert'
    else
      render :edit_settings, alert: 'Einstellungen konnten nicht gespeichert werden'
    end
  end

  private

  def settings_params
    params.permit(:table_settings, :navbar_color_settings, :navbar_bg_settings, :show_mobile_on_pdf)
  end

  def authenticate_user
    if user_signed_in?
      @user = current_user
    else
      redirect_to root_path
    end
  end

  def set_user_tasks
    @partner = Partner.find_by(email: @user.email)
    tasks = @user.tasks
    if @partner
      tasks = tasks.or(@partner.tasks)
    end
    @pagy, @tasks = filter_tasks(tasks)
  end
end
