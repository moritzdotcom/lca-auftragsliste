class PartnersController < ApplicationController
  before_action :set_partner, only: [:show, :edit, :update]
  before_action :authorise_user, except: [:index, :show]
  before_action only: [:show] do
    @pagy, @tasks = filter_tasks(@partner.tasks)
  end

  def index
    if params[:search]
      wildcard_search = "%#{params[:search].downcase}%"
      @partners = Partner.where("LOWER(name) LIKE ? OR LOWER(email) LIKE ?", wildcard_search, wildcard_search).order(:name)
    else
      @partners = Partner.order(:name)
    end
  end

  def show
  end

  def new
    @partner = Partner.new
  end

  def create
    @partner = Partner.find_by(name: partner_params[:name].strip, company: @company) || Partner.new(name: partner_params[:name].strip, company: @company)

    respond_to do |format|
      format.html do
        if @partner.save
          if partner_params[:task_id]
            @task = Task.find(partner_params[:task_id])
            @task.update(partner_array: @task.partner_array + ";&#{@partner.id}", mail_sent: false)
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

      format.json do
        if @partner.save
          render json: {message: 'Partner Erstellt', partner: @partner}, status: 200
        else
          render json: {message: @partner.errors.full_messages}, status: 500
        end
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
    params.require(:partner).permit(:name, :company_name, :email, :phone_number, :task_id)
  end

  def authorise_user
    if user_signed_in?
      return if action_name == 'create' && partner_params[:task_id] && Task.find(partner_params[:task_id]) && Task.find(partner_params[:task_id]).user == @user
      return if @user.admin || @user.can_manage_partners
    end

    redirect_to root_path
  end
end
