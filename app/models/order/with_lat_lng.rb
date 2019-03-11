class Order::WithLatLng < Order

  reverse_geocoded_by :latitude, :longitude, address: :address

  after_validation :reverse_geocode
end