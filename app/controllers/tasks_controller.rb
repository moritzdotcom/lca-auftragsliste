class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_task_update, only: [:update_status, :update_priority, :update_due_date, :update_title, :update_description, :new_email]
  before_action :authorise_user, except: [:index, :show, :new_email]
  before_action only: [:index] do
    if params[:search]
      wildcard_search = "%#{params[:search].downcase}%"
      tasks = Task.joins(:house).where("LOWER(title) LIKE ? OR LOWER(description) LIKE ? OR LOWER(partner_names) LIKE ? OR LOWER(houses.address) LIKE ?", wildcard_search, wildcard_search, wildcard_search, wildcard_search)
    else
      tasks = Task.all
    end

    @pagy, @tasks = filter_tasks(tasks)
  end

  def index
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
      partners.map! { |partner| partner.to_i.to_s == partner && Partner.find(partner) ? Partner.find(partner).id : Partner.create(name: partner, company: house.company).id }

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
    status_params = params.require(:task).permit(:status)
    @task.update(status_params)
    redirect_to @task, notice: 'Status gespeichert'
  end

  def update_priority
    priority_params = params.require(:task).permit(:priority)
    @task.update(priority_params)
    redirect_to @task, notice: 'Priorität gespeichert'
  end

  def update_due_date
    due_date_params = params.require(:task).permit(:due_date)
    @task.update(due_date_params)
    redirect_to @task, notice: 'Fälligkeit gespeichert'
  end

  def update_title
    title_params = params.require(:task).permit(:title)
    @task.update(title_params)
    redirect_to @task, notice: 'Beschreibung gespeichert'
  end

  def update_description
    description_params = params.require(:task).permit(:description)
    @task.update(description_params)
    redirect_to @task, notice: 'Weitere Bemerkungen gespeichert'
  end

  def new_email
    if @task.mail_sent
      redirect_to @task, alert: 'Email wurde bereits versendet'
    else
      TaskMailer.task_email(@task).deliver
      last_update = @task.updated_at
      @task.update(mail_sent: true)
      @task.update(updated_at: last_update)
      redirect_to @task, notice: 'Email wurde versendet'
    end
  end

  def calendar
    @tasks = Task.all
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

  def set_task_update
    @task = Task.find(params[:task_id])
  end

  def task_params
    parameters = params.require(:task).permit(:task_number, :house_id, :flat_id, :flat_location, :tenant_id, :tenant_name, :location, :partner_array, :user_id, :title, :description, :due_date, :created_at, :priority)
    parameters[:created_at] = parameters[:created_at].to_datetime
    parameters[:due_date] = parameters[:due_date].to_datetime

    return parameters
  end

  def authorise_user
    if user_signed_in?
      redirect_to @task, alert: 'Du kannst den Auftrag nicht bearbeiten' if @task && (@task.user != current_user && !current_user.admin)
      return if current_user.admin || current_user.can_create_tasks
    end

    redirect_to root_path
  end
end
