class OrderSerializer < ActiveModel::Serializer
  attributes :id, :code, :date, :client_name, :client_phone, :spouse_name, :spouse_phone, :address_one, :neighborhood_address_one, :address_two, :neighborhood_address_two, :familiar_reference, :familiar_reference_phone, :personal_reference, :personal_reference_phone, :payment_date, :observations, :quota_quantity, :quota_amount, :total_paid, :latitude, :longitude
  has_one :department
  has_one :city
end
