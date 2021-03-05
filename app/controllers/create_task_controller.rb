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
      @partners = Partner.for_company(@company).where.not(id: @task.partners.pluck(:id)).order(name: :asc)
    when :update_partners
      @partners = Partner.where(id: params[:partner_ids])
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
      new_partner_ids = []

      partner_params = params.require(:task).permit(:partner_array)

      if partner_params[:partner_array].length.positive?
        partners = partner_params[:partner_array].split(';&')
        partners.map! do |partner|
          if partner.to_i.to_s == partner && Partner.find(partner)
            return Partner.find(partner).id
          else
            new_partner_id = Partner.create(name: partner, company: @company).id
            new_partner_ids << new_partner_id
            return new_partner_id
          end
        end

        partner_array = partners.join(';&')

        @task.update(partner_array: partner_array)
        @task.set_partner_names!
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
