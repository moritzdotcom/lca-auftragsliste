class FlatsController < ApplicationController
  def index
    @house = House.find(params[:house_id])
    @flats = @house.flats

    respond_to do |format|
      format.html
      format.json
    end
  end
end
