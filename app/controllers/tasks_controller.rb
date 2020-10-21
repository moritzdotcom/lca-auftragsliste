class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index

    if params[:order]
      option = params[:desc] == 'true' ? :desc : :asc

      case params[:order]
      when 'task_number'
        @tasks = Task.order(task_number: option)
      when 'created_at'
        @tasks = Task.order(created_at: option)
      when 'object_number'
        @tasks = Task.joins(:house).order(object_number: option)
      when 'address'
        @tasks = Task.joins(:house).order(address: option)
      when 'flat'
        @tasks = Task.joins(:flat).order(location: option)
      when 'tenant'
        @tasks = Task.joins(:tenant).order(name: option)
      when 'title'
        @tasks = Task.order(title: option)
      when 'user'
        @tasks = Task.joins(:user).order(first_name: option)
      when 'partner'
        @tasks = Task.order(partner_array: option)
      when 'status'
        @tasks = Task.order(status: option)
      end
    else
      @tasks = Task.order(task_number: :desc)
    end
  end

  def show
    respond_to do |format|
      format.html

      format.pdf do
        template = params[:internal] ? 'internal' : 'external'
        render pdf: "Auftrag Nr. #{@task.prefix_number}",
               page_size: 'A4',
               template: "tasks/show_#{template}_pdf.html.erb",
               layout: 'pdf.html',
               orientation: 'Portrait',
               lowquality: true,
               zoom: 1,
               dpi: 75
      end
    end
  end

  def new
    @task = Task.new(task_number: Task.next_number, status: 0)
  end

  def edit
  end

  def create
    @task = Task.new

    parameters = task_params
    if parameters[:house_id].length.positive?
      house = House.find(parameters[:house_id])

      if parameters[:flat_id].length == 0
        flat = Flat.new(location: parameters[:flat_location])
        flat.house = house

        if flat.save
          parameters[:flat_id] = flat.id
        else
          @task.errors[:flat_id] << 'Wohnung muss angegeben werden'
        end
      else
        flat = Flat.find(parameters[:flat_id])
      end

    else
      @task.errors[:house_id] << 'Objekt muss angegeben werden'
    end

    update_tenant = false

    if parameters[:tenant_id].length == 0
      @tenant = Tenant.new(name: parameters[:tenant_name])
      @tenant.flat = flat

      if @tenant.save
        update_tenant = true
        parameters[:tenant_id] = @tenant.id
      else
        @task.errors[:tenant] << 'Mieter muss angegeben werden'
      end
    else
      @tenant = Tenant.find(parameters[:tenant_id])
    end

    if parameters[:partner_array].length.positive?
      partners = parameters[:partner_array].split(';&')
      partners.map! { |partner| partner.to_i.to_s == partner && Partner.find(partner) ? Partner.find(partner).id : Partner.create(name: partner).id }

      parameters[:partner_array] = partners.join(';&')
    end

    @task.update(parameters.except(:flat_location, :tenant_name))

    if @task.save && update_tenant
      redirect_to edit_tenant_path(@tenant), notice: 'Trage eine Telefonnummer für den Mieter ein'
    elsif @task.save
      redirect_to @task, notice: 'Auftrag wurde erfolgreich erstellt'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_status
    @task = Task.find(params[:task_id])
    status_params = params.require(:task).permit(:status)
    @task.update(status_params)
    redirect_to @task
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      parameters = params.require(:task).permit(:task_number, :house_id, :flat_id, :flat_location, :tenant_id, :tenant_name, :location, :partner_array, :user_id, :title, :description, :due_date, :created_at)
      parameters[:created_at] = parameters[:created_at].to_datetime
      parameters[:due_date] = parameters[:due_date].to_datetime

      return parameters
    end
end
