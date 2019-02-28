class Order < ApplicationRecord
  belongs_to :department
  belongs_to :city

  belongs_to :user, required: false
  has_and_belongs_to_many :wares

  has_many :orders_wares
  has_many :payments, :dependent => :delete_all

  # attr_accessible :title, :assets_attributes
  accepts_nested_attributes_for :orders_wares, allow_destroy: true

  validates :client_name, 
            :client_phone,
            :neighborhood_address_one,
            :address_one,
            :familiar_reference,
            :familiar_reference_phone,
            :personal_reference,
            :personal_reference_phone,
            presence: true

  validates :quota_quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :quota_amount, presence: true, numericality: { greater_than: 0 }

  geocoded_by :address

  # after_validation :geocode, :if => :address_changed?
  # before_validation :set_coords_to_nil, :if => :address_changed?

  # after_validation :geocode
  # after_validation :geocode, if: ->(obj){ obj.latitude.present? and obj.longitude.present? }
  validates :latitude, :presence => {message: "Not a valid location on Google Maps, please check name address & country fields" }


  after_create :create_payments



  def address
    [
      department.country.name,
      department.name,
      city.name,
      address_one,
      neighborhood_address_one
    ].compact.join(', ')
  end


  def create_payments
    quota_quantity.times do |index|
      payment = self.payments.create(
        total_paid: self.quota_amount,
        date: index == 0 ? self.date : 15.business_days.after(self.payments.order(date: :asc).pluck(:date).last),# n.days depending of selection in order
        status: :pending,
        latitude: self.latitude,
        longitude: self.longitude
      )
    end
  end
  

  # def address_changed?
  #   attrs = %w(
  #     department.country.name,
  #     department.name,
  #     city.name,
  #     address_one,
  #     neighborhood_address_one
  #   )
  #   attrs.any?{|a| send "#{a}_changed?"}
  # end


  def set_coords_to_nil
    self.latitude = nil
    self.longitude = nil
  end
end
