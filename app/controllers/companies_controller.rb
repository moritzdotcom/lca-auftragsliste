class CompaniesController < ApplicationController
  skip_before_action :set_company, only: [:new, :create]
  before_action :authorise_super_user, only: :index
  before_action :authorise_user, only: [:edit, :update]

  def index
    @companies = Company.all
  end

  def show
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to new_user_registration_path(company_id: @company.uuid)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to @company
    else
      render :edit
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :email, :logo, :pdf_logo)
  end

  def authorise_user
    return if @user.admin

    redirect_to root_path
  end

  def authorise_super_user
    return if @user.superadmin

    redirect_to root_path
  end
end
