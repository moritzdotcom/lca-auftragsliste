class PartnersController < ApplicationController
  include Pagy::Backend
  before_action :set_partner, only: [:show, :edit, :update]
  before_action :authorise_user, except: [:index, :show]

  def index
    if params[:search]
      wildcard_search = "%#{params[:search]}%"
      @partners = Partner.where("name LIKE ? OR email LIKE ?", wildcard_search, wildcard_search).order(:name)
    else
      @partners = Partner.order(:name)
    end
  end

  def show
    pagy_options = {items: user_signed_in? ? (current_user.table_settings || 20) : 20, size: [1,2,2,1]}

    if params[:order]
      params[:page] = 1
      option = params[:desc] == 'true' ? :desc : :asc

      case params[:order]
      when 'task_number'
        @pagy, @tasks = pagy(@partner.tasks.order(task_number: option), pagy_options)
      when 'created_at'
        @pagy, @tasks = pagy(@partner.tasks.order(created_at: option), pagy_options)
      when 'object_number'
        @pagy, @tasks = pagy(@partner.tasks.joins(:house).order(object_number: option), pagy_options)
      when 'address'
        @pagy, @tasks = pagy(@partner.tasks.joins(:house).order(address: option), pagy_options)
      when 'flat'
        @pagy, @tasks = pagy(@partner.tasks.joins(:flat).order(location: option), pagy_options)
      when 'tenant'
        @pagy, @tasks = pagy(@partner.tasks.joins(:tenant).order(name: option), pagy_options)
      when 'title'
        @pagy, @tasks = pagy(@partner.tasks.order(title: option), pagy_options)
      when 'user'
        @pagy, @tasks = pagy(@partner.tasks.joins(:user).order(first_name: option), pagy_options)
      when 'partner'
        @pagy, @tasks = pagy(@partner.tasks.order(partner_array: option), pagy_options)
      when 'status'
        @pagy, @tasks = pagy(@partner.tasks.order(status: option), pagy_options)
      end
    else
      @pagy, @tasks = pagy(@partner.tasks.order(:task_number), pagy_options)
    end
  end

  def new
    @partner = Partner.new
  end

  def create
    @partner = Partner.find_by(name: partner_params[:name]) || Partner.new(partner_params[:name])

    if @partner.save
      if partner_params[:task_id]
        @task = Task.find(partner_params[:task_id])
        @task.update(partner_array: @task.partner_array + ";&#{@partner.id}")
        redirect_to @task, notice: 'Partner erfolgreich hinzugefügt'
      else
        redirect_to @partner, notice: 'Partner erfolgreich erstellt'
      end
    else
      if partner_params[:task_id]
        redirect_to Task.find(partner_params[:task_id]), alert: @partner.errors.full_messages.join(' & ')
      else
        redirect_to @partner, alert: @partner.errors.full_messages.join(' & ')
      end
    end
  end

  def edit
  end

  def update
    if @partner.update(partner_params.except(:task_id))
      if partner_params[:task_id]
        redirect_to Task.find(partner_params[:task_id]), notice: 'Partner wurde aktualisiert'
      else
        redirect_to @partner, notice: 'Partner wurde aktualisiert'
      end
    else
      if partner_params[:task_id]
        redirect_to Task.find(partner_params[:task_id]), alert: @partner.errors.full_messages.join(' & ')
      else
        redirect_to @partner, alert: @partner.errors.full_messages.join(' & ')
      end
    end
  end

  private

  def set_partner
    @partner = Partner.find(params[:id])
  end

  def partner_params
    params.require(:partner).permit(:name, :email, :phone_number, :task_id)
  end

  def authorise_user
    if user_signed_in?
      return if current_user.admin || current_user.can_manage_partners
    end

    redirect_to root_path
  end
end
