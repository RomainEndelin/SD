module Location
  extend ActiveSupport::Concern

  included do
    validates :country, presence: true
  end

  def country_name
    _country = ISO3166::Country[country]
    _country.translations[I18n.locale.to_s] || _country.name
  end

  def location
    (city.nil? || city.empty?) ? country_name : "#{city}, #{country_name}"
  end

  def full_location
    _country = ISO3166::Country[country]
    "#{location}, #{_country.region}, #{_country.subregion}"
  end
end
