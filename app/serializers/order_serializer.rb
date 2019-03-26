class OrderSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper

  has_many :payments

  attributes :id,
             :code,
             :client_name,
             :user_id,
             :collector_id,
             :enterprise_id,
             :client_phone,
             :quota_amount,
             :latitude,
             :longitude,
             :payment_pending,
             # :address,
             :status,
             :address_one,
             :neighborhood_address_one,
             :date,
             :due_id,
             :familiar_reference,
             :familiar_reference_phone,
             :payment_date,
             :personal_reference,
             :personal_reference_phone,
             :quota_amount,
             :quota_quantity,
             :orders_wares_attributes,

  # has_one :department
  # has_one :city
  # has_one :user


  def payment_pending
    number_to_currency(object.quota_amount)
  end

  def address
    [
      object.address_one,
      object.neighborhood_address_one,
      # object.city.name.capitalize
    ].join(', ')
  end

  def total
    object.orders_wares.sum(&:total)
  end

  def latitude
    object.latitude.to_f
  end

  def longitude
    object.longitude.to_f
  end

  def orders_wares_attributes
    object.orders_wares
  end
end
