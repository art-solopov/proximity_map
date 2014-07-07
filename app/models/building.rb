# (c) 2014 Солопов Артемий Ильич / Artemiy Solopov

include Math

EARTH_RADIUS = 6378168

# Haversine function to calculate the distance
def haversin(theta)
  (1 - cos(theta)) / 2.0
end

class Building < ActiveRecord::Base
  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longtitude, presence: true

  attr_accessor :distance # Local variable for distance storing

  scope :within, lambda {|lat, lon, dist|
    where(%q{earth_distance(
              ll_to_earth(?, ?),
              ll_to_earth(buildings.latitude, buildings.longtitude)
            ) <= ?},
          lat, lon, dist)
  }

  Point = Struct.new(:latitude, :longtitude)

  def distance_to(point)
    lat1, lon1, lat2, lon2 = 
      [latitude, longtitude, point.latitude, point.longtitude].
      map{|e| e * PI / 180} # Convert degrees to radians
    hav = haversin(lat2 - lat1) + cos(lat1) * cos(lat2) * haversin(lon2 - lon1)
    2 * EARTH_RADIUS * asin(sqrt(hav))
  end

  def self.near(lat, lon, radius=4000)
    buildings = Building.within(lat, lon, radius)
    buildings.each{|b| b.distance = b.distance_to(Point.new(lat, lon))}
    buildings
  end

end
