class Search < ActiveRecord::Base
  geocoded_by :name
  after_validation :geocode

  scope :most_recent, -> { all.last(5).reverse }
end
