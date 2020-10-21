class PartnersController < ApplicationController
  before_action :set_partner, only: [:show, :edit, :update]

  def index
    @partners = Partner.all.order(:name)
  end

  def show
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
