class HousesController < ApplicationController
  before_action :set_house, only: [:show, :edit, :update]
  before_action :set_houses, only: [:index, :edit_all]
  before_action :authorise_user, except: [:index, :show]

  def index
  end

  def show
  end

  def edit_all
  end

  def update
    if @house.update(house_params)
      redirect_to edit_houses_path(anchor: "house-#{@house.id}"), notice: 'Änderungen wurden gespeichert'
    else
      render :edit_all
    end
  end

  private

  def authorise_user
    if user_signed_in?
      return if current_user.admin || current_user.can_manage_houses
    end

    redirect_to root_path
  end

  def house_params
    params.require(:house).permit(:company, :user_id)
  end

  def set_house
    @house = House.find(params[:id])
  end

  def set_houses
    @houses = House.order(:object_number)
  end
end
