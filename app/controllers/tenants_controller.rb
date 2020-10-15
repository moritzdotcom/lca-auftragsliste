class TenantsController < ApplicationController
  before_action :set_tenant, only: [:edit, :update]

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
