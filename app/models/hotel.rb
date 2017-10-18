class Hotel < ApplicationRecord
  scope :hotel_name, ->(hotel_name) { where "lower(hotel_name) like ?", "%#{hotel_name.downcase}%" }
  scope :city, ->(city) { where "lower(city) like ?", "%#{city.downcase}%" }
  scope :country, ->(country) { where "lower(country) like ?", "%#{country.downcase}%" }
  scope :description, ->(description) { where "lower(description) like ?", "%#{description.downcase}%" }

  def self.search_hotels(search)
    if search
      where("hotel_name ILIKE :search OR city ILIKE :search OR country ILIKE :search OR description ILIKE :search", search: "%#{search}%")
    else
      all
    end
  end
end
