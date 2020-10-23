class FlatsController < ApplicationController
  before_action :set_flat, only: [:destroy]
  before_action :set_house, only: [:new, :create]

  def index
    @house = House.find(params[:house_id])
    @flats = @house.flats

    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @flat = Flat.new(house: @house)
  end

  def create
    @flat = Flat.new(flat_params)

    if @flat.save
      redirect_to houses_path(house: @flat.house.id), notice: 'Wohnung wurde erstellt'
    else
      render :new
    end
  end

  def destroy
    @house = @flat.house
    @flat.destroy
    redirect_to houses_path(house: @house.id), alert: 'Wohnung gelöscht'
  end

  private

  def set_house
    @house = House.find(params[:house_id])
  end

  def set_flat
    @flat = Flat.find(params[:id])
  end

  def flat_params
    params.require(:flat).permit(:location, :house_id)
  end
end
