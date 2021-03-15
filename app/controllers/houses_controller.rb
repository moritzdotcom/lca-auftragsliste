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
      # redirect_to edit_houses_path(anchor: "house-#{@house.id}"), notice: 'Änderungen wurden gespeichert'
      render json: {message: 'Änderungen gespeichert'}, status: 200
    else
      render json: {message: 'Da ist leider etwas schief gelaufen'}, status: 500
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
    params.require(:house).permit(:owner_id, :user_id)
  end

  def set_house
    @house = House.for_company(@company).find(params[:id])
  end

  def set_houses
    @houses = House.for_company(@company).order(:object_number)
  end
end
