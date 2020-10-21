class PartnersController < ApplicationController
  before_action :set_partner, only: [:show, :edit, :update]

  def index
    @partners = Partner.all.order(:name)
  end

  def show
    if params[:order]
      option = params[:desc] == 'true' ? :desc : :asc

      case params[:order]
      when 'task_number'
        @tasks = @partner.tasks.order(task_number: option)
      when 'created_at'
        @tasks = @partner.tasks.order(created_at: option)
      when 'object_number'
        @tasks = @partner.tasks.joins(:house).order(object_number: option)
      when 'address'
        @tasks = @partner.tasks.joins(:house).order(address: option)
      when 'flat'
        @tasks = @partner.tasks.joins(:flat).order(location: option)
      when 'tenant'
        @tasks = @partner.tasks.joins(:tenant).order(name: option)
      when 'title'
        @tasks = @partner.tasks.order(title: option)
      when 'user'
        @tasks = @partner.tasks.joins(:user).order(first_name: option)
      when 'partner'
        @tasks = @partner.tasks.order(partner_array: option)
      when 'status'
        @tasks = @partner.tasks.order(status: option)
      end
    else
      @tasks = @partner.tasks.sort_by(&:task_number)
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
end
