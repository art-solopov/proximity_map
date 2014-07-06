class MapController < ApplicationController

  WITHIN_DISTANCE=4000

  def show
  end

  def search_within
    @latitude = params[:lat]
    @longtitude = params[:lon]
    if @latitude and @longtitude
      @buildings = Building.within(@latitude, @longtitude, WITHIN_DISTANCE)
    else
      @buildings = []
    end

    respond_to do |format|
      format.html
      format.json { render json: @buildings}
    end
  end
end
