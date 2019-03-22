class WebOrder < Order

  geocoded_by :address

  after_validation :geocode, if: -> (obj){  obj.department.present? and obj.city.present? and obj.address.present? and obj.address_changed? }

  def address
    [
      department.country.name,
      department.name,
      city.name,
      address_one,
      neighborhood_address_one
    ].compact.join(', ')
  end

  def address_changed?
    attrs = %w(
      address_one
      neighborhood_address_one
    )
    attrs.any?{|a| send "#{a}_changed?"}
  end

end