class ApiOrder < Order

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      # obj.city    = geo.city
      # obj.zipcode = geo.postal_code
      # obj.country = geo.country_code
    end
  end
  after_validation :reverse_geocode
end