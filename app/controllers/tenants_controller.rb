class TenantsController < ApplicationController
  before_action :set_tenant, only: [:edit, :update]

  def new
    @tenant = Tenant.new(flat_id: params[:flat])
  end

  def create
    @tenant = Tenant.new(tenant_params)

    if @tenant.save
      redirect_to houses_path(house: @tenant.flat.house.id), notice: 'Mieter wurde gespeichert'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @tenant.update(tenant_params)

    if @tenant.save
      redirect_to tasks_path, notice: 'Mieter wurde gespeichert'
    else
      render :edit
    end
  end

  private

  def set_tenant
    @tenant = Tenant.find(params[:id])
  end

  def tenant_params
    params.require(:tenant).permit(:name, :flat_id, :phone_number)
  end
end
