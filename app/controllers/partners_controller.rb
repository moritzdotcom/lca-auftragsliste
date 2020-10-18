class PartnersController < ApplicationController
  before_action :set_partner, only: [:show, :edit, :update]

  def index
    @partners = Partner.all
  end

  def show
  end

  def new
    @partner = Partner.new
  end

  def create
    @partner = Partner.new(partner_params.except(:task_id))

    if @partner.save
      redirect_to @partner, notice: 'Partner erfolgreich erstellt'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @partner.update(partner_params.except(:task_id))
      if partner_params[:task_id]
        redirect_to Task.find(partner_params[:task_id]), notice: 'Partner wurde aktualisiert'
      else
        redirect_to @partner
      end
    else
      if partner_params[:task_id]
        redirect_to Task.find(partner_params[:task_id]), alert: @partner.errors.full_messages.join('& ')
      else
        render :edit
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
