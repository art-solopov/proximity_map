class Building < ActiveRecord::Base
  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longtitude, presence: true

  scope :within, lambda {|lat, lon, dist|
    where(%q{earth_distance(
              ll_to_earth(?, ?),
              ll_to_earth(buildings.latitude, buildings.longtitude)
            ) <= ?},
          lat, lon, dist)
  }

end
