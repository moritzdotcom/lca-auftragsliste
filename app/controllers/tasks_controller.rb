class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_task_update, only: [:update_status, :update_priority, :update_due_date, :update_title, :update_description, :new_email]
  before_action :authorise_user, except: [:index, :show, :new_email]
  before_action only: [:index] do
    if params[:search]
      wildcard_search = "%#{params[:search].downcase}%"
      tasks = Task.for_company(@company).joins(:house).where("LOWER(title) LIKE ? OR LOWER(description) LIKE ? OR LOWER(partner_names) LIKE ? OR LOWER(houses.address) LIKE ?", wildcard_search, wildcard_search, wildcard_search, wildcard_search).order_by_task_number(:desc)
    else
      tasks = Task.for_company(@company)
    end

    @pagy, @tasks = filter_tasks(tasks)
  end

  def index
    meta_tags_for(title: 'Aufträge', description: 'Liste aller Aufträge')
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
    @task = Task.new
    @houses = House.for_company(@company)
  end

  def create
    @task = Task.new

    house = nil
    flat = nil
    tenant = nil

    parameters = task_params
    if parameters[:house_id].length.positive?
      house = House.find(parameters[:house_id])

      if parameters[:flat_id].length == 0
        flat = Flat.new(location: parameters[:flat_location].strip)
        flat.house = house

        unless flat.save
          @task.errors[:flat_id] << 'Wohnung muss angegeben werden'
        end
      else
        flat = Flat.find(parameters[:flat_id])
      end

    else
      @task.errors[:house_id] << 'Objekt muss angegeben werden'
    end

    update_tenant = false

    if parameters[:tenant_id].length == 0 || Tenant.find_by(id: parameters[:tenant_id], name: parameters[:tenant_name].strip).nil?
      tenant = Tenant.new(name: parameters[:tenant_name].strip)
      tenant.flat = flat

      if tenant.save
        update_tenant = true
      else
        @task.errors[:tenant] << 'Mieter muss angegeben werden'
      end
    else
      tenant = Tenant.find_by(id: parameters[:tenant_id])
    end

    @task.update(user: @user, company: @user.company, task_number: Task.next_number(@user.company), status: 0, priority: 0, house: house, flat: flat, tenant: tenant, released: false)

    if @task.valid? && update_tenant
      redirect_to task_create_task_path(@task, :update_tenant)
    elsif @task.valid?
      redirect_to task_create_task_path(@task, :task_info)
    else
      render :new
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @task.update(update_params) && @user.can_edit_task(@task)
        format.html { redirect_to @task, notice: 'Auftrag gespeichert' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_email
    partners = @task.partners
    partner_mails = partners.map(&:email).compact

    if @task.mail_sent
      redirect_to @task, alert: 'Email wurde bereits versendet'
    elsif partner_mails.length.zero?
      redirect_to @task, alert: 'Deine Partner haben noch keine Email. Auftrag wurde nicht verschickt'
    elsif !['internal', 'external'].include?(params[:layout])
      redirect_to @task, alert: "Unbekanntes Layout: #{params[:layout]}. Auftrag wurde nicht verschickt"
    else
      TaskMailer.task_email(task: @task, partner_emails: partner_mails.join(','), partners: partners, layout: params[:layout]).deliver
      last_update = @task.updated_at
      @task.update(mail_sent: true)
      @task.update(updated_at: last_update)
      redirect_to @task, notice: "Email wurde an #{partner_mails.join(', ')} versendet"
    end
  end

  def calendar
    @tasks = Task.for_company(@company)
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
    parameters = params.require(:task).permit(:task_number, :house_id, :flat_id, :flat_location, :tenant_id, :tenant_name, :location)

    return parameters
  end

  def update_params
    params.require(:task).permit(:due_date, :status, :priority, :title, :description)
  end

  def authorise_user
    if user_signed_in?
      redirect_to @task, alert: 'Du kannst den Auftrag nicht bearbeiten' if @task && (@task.user != @user && !@user.admin)
      return if @user.admin || @user.can_create_tasks
    end

    redirect_to root_path
  end
end
