class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone_number, :mobile_phone ])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :mobile_phone ])
  end

  def filter_tasks(tasks)
    pagy_options = {items: user_signed_in? ? (current_user.table_settings || 20) : 20, size: [1,2,2,1]}

    if params[:order]
      option = params[:desc] == 'true' ? :desc : :asc

      case params[:order]
      when 'task_number', 'created_at', 'title', 'status', 'partner_names', 'priority'
        @tasks = tasks.order(params[:order] => option)
      when 'object_number', 'address'
        @tasks = tasks.joins(:house).order(params[:order] => option)
      when 'flat'
        @tasks = tasks.joins(:flat).order(location: option)
      when 'tenant'
        @tasks = tasks.joins(:tenant).order(name: option)
      when 'user'
        @tasks = tasks.joins(:user).order(first_name: option)
      end
    else
      @tasks = tasks.order(task_number: :desc)
    end

    if params[:query]
      case params[:query]
      when 'status_open'
        @tasks = @tasks.where(status: 0)
      when 'due_date'
        @tasks = @tasks.where('due_date >= ?', Date.today)
      when 'over_due'
        @tasks = @tasks.where('due_date < ?', Date.today)
      end
    end

    pagy(@tasks, pagy_options)
  end
end
