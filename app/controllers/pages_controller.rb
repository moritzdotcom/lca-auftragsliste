class PagesController < ApplicationController
  skip_before_action :set_company, only: [:landing]
  before_action :authenticate_user, except: [:landing]
  before_action :set_user_tasks, only: [:dashboard]

  def landing
  end

  def dashboard
    @tasks = Task.for_company(@company)
  end

  def edit_settings
  end

  def update_settings
    if @user.admin
      User.all.each do |user|
        params["users_can_create_tasks_#{user.id}"] ? user.update(can_create_tasks: true) : user.update(can_create_tasks: false)
        params["users_can_manage_houses_#{user.id}"] ? user.update(can_manage_houses: true) : user.update(can_manage_houses: false)
        params["users_can_manage_partners_#{user.id}"] ? user.update(can_manage_partners: true) : user.update(can_manage_partners: false)
      end
    end

    if @user.update(settings_params)
      @user.update(show_mobile_on_pdf: false) unless settings_params[:show_mobile_on_pdf]
      redirect_to edit_settings_path, notice: 'Einstellungen gespeichert'
    else
      render :edit_settings, alert: 'Einstellungen konnten nicht gespeichert werden'
    end
  end

  def mail_log
    redirect_to root_path unless current_user.admin

    @mails = MailLog.order(date: :desc)
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
    @partner = Partner.for_company(@company).find_by(email: @user.email)
    tasks = @user.tasks
    if @partner
      tasks = tasks.or(@partner.tasks)
    end
    @pagy, @user_tasks = filter_tasks(tasks)
  end
end
