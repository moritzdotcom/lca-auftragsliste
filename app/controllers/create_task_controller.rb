class CreateTaskController < ApplicationController
  before_action :set_task, only: [:show, :update]
  include Wicked::Wizard

  steps :update_tenant, :task_info, :set_partners, :update_partners

  def show
    case step
    when :update_tenant
      @tenant = @task.tenant
      @house_id = @task.house.id
    when :set_partners
      @partners = Partner.for_company(@company)
    end

    render_wizard
  end

  def update
    case step
    when :update_tenant
      @tenant = @task.tenant
      @tenant.update(tenant_params)
    when :task_info
      task_params = params.require(:task).permit(:title, :description, :due_date, :priority)
      @task.update(task_params)
    when :set_partners
      if parameters[:partner_array].length.positive?
        partners = parameters[:partner_array].split(';&')
        partners.map! { |partner| partner.to_i.to_s == partner && Partner.find(partner) ? Partner.find(partner).id : Partner.create(name: partner, company: house.company).id }

        parameters[:partner_array] = partners.join(';&')
      end
    when :update_partners

    end

    render_wizard @task
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end

  def tenant_params
    params.require(:tenant).permit(:name, :flat_id, :phone_number)
  end
end
