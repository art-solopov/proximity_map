# (c) 2014 Солопов Артемий Ильич / Artemiy Solopov
class MapController < ApplicationController

  def show
  end

  def search_within
    @latitude = params[:lat].to_f
    @longtitude = params[:lon].to_f
    if @latitude and @longtitude
      @buildings = Building.near(@latitude, @longtitude)
    else
      @buildings = []
    end

    json = @buildings.map{|b|
      attrib = b.attributes
      attrib['distance'] = b.distance
      attrib}.to_json

    respond_to do |format|
      format.json { render json: json}
    end
  end
end
