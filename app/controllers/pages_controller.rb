class PagesController < ApplicationController
  before_action :authenticate_user

  def dashboard
    pagy_options = {items: user_signed_in? ? (current_user.table_settings || 20) : 20, size: [1,2,2,1]}

    @partner = Partner.find_by(email: @user.email)
    if @partner
      if params[:order]
        params[:page] = 1
        option = params[:desc] == 'true' ? :desc : :asc

        case params[:order]
        when 'task_number'
          @pagy, @tasks_for_user = pagy(@partner.tasks.order(task_number: option), pagy_options)
        when 'created_at'
          @pagy, @tasks_for_user = pagy(@partner.tasks.order(created_at: option), pagy_options)
        when 'object_number'
          @pagy, @tasks_for_user = pagy(@partner.tasks.joins(:house).order(object_number: option), pagy_options)
        when 'address'
          @pagy, @tasks_for_user = pagy(@partner.tasks.joins(:house).order(address: option), pagy_options)
        when 'flat'
          @pagy, @tasks_for_user = pagy(@partner.tasks.joins(:flat).order(location: option), pagy_options)
        when 'tenant'
          @pagy, @tasks_for_user = pagy(@partner.tasks.joins(:tenant).order(name: option), pagy_options)
        when 'title'
          @pagy, @tasks_for_user = pagy(@partner.tasks.order(title: option), pagy_options)
        when 'user'
          @pagy, @tasks_for_user = pagy(@partner.tasks.joins(:user).order(first_name: option), pagy_options)
        when 'partner'
          @pagy, @tasks_for_user = pagy(@partner.tasks.order(partner_array: option), pagy_options)
        when 'status'
          @pagy, @tasks_for_user = pagy(@partner.tasks.order(status: option), pagy_options)
        end
      else
        @pagy, @tasks = pagy(@partner.tasks.order(:task_number), pagy_options)
      end

    @tasks = @user.tasks
      @tasks_for_user = @partner.tasks
    end
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
end
