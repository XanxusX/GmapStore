class Store < ActiveRecord::Base
  validates :name, presence: true

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  geocoded_by :address
  after_validation :geocode

  has_many :reviews
end
