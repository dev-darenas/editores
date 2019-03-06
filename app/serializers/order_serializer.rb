class OrderSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper

  attributes :id,
             :code,
             :client_name,
             :client_phone,
             :quota_amount,
             :latitude,
             :longitude,
             :payment_pending,
             :address

  has_one :department
  has_one :city

  has_many :payments

  def payment_pending
    number_to_currency(object.quota_amount)
  end

  def address
    [
      object.address_one,
      object.neighborhood_address_one,
      object.city.name.capitalize
    ].join(', ')
  end

  def latitude
    object.latitude.to_f
  end

  def longitude
    object.longitude.to_f
  end
end
