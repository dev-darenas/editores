class Order::WithAddress < Order
  
  belongs_to :country
  belongs_to :department
  belongs_to :city
  
  geocoded_by :address
  
  # after_validation :geocode

  after_validation :geocode, if: -> (obj){  obj.department.present? and obj.city.present? and obj.address.present? and obj.address_changed? }
  after_validation :lat_changed?

  def address
    [
      department.country.name,
      department.name,
      city.name,
      address_one,
      neighborhood_address_one
    ].compact.join(', ')
  end


  def lat_changed?
    if (self.address_changed?)
      if !(self.latitude_changed?)
        self.errors.add(:address, "is not valid")
        return false
      end
    end
    return true
  end

  def address_changed?
    attrs = %w(
      address_one
      neighborhood_address_one
    )
    attrs.any?{|a| send "#{a}_changed?"}
  end

end