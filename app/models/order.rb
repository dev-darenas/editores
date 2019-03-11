class Order < ApplicationRecord
  belongs_to :country, required: false
  belongs_to :department, required: false
  belongs_to :city, required: false

  belongs_to :user, required: false
  has_and_belongs_to_many :wares

  has_many :orders_wares
  has_many :payments, :dependent => :delete_all

  has_one :due

  # attr_accessible :title, :assets_attributes
  accepts_nested_attributes_for :orders_wares, allow_destroy: true

  validates :client_name, 
            :due_id,
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

  # geocoded_by :address

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      p "@@@@@@@@@"
      p geo.inspect
      p "@@@@@@@@@"
      # obj.city    = geo.city
      # obj.zipcode = geo.postal_code
      # obj.country = geo.country_code
    end
  end
  after_validation :reverse_geocode

  # after_validation :geocode, :if => :address_changed?
  # before_validation :set_coords_to_nil, :if => :address_changed?
  # after_validation :geocode, if: -> (obj){  obj.department.present? and obj.city.present? and obj.address.present? and obj.address_changed? }
  # after_validation :lat_changed?

  # after_validation :geocode
  # after_validation :geocode, if: ->(obj){ obj.latitude.present? and obj.longitude.present? }
  # validates :latitude, :presence => {message: "Not a valid location on Google Maps, please check name address & country fields" }
  # after_create :create_payments

  enum status: [:pending, :returned, :completed]

  def address
    [
      department.country.name,
      department.name,
      city.name,
      address_one,
      neighborhood_address_one
    ].compact.join(', ')
  end

  def check_status
    :pending
  end


  # def create_payments
  #   quota_quantity.times do |index|
  #     payment = self.payments.create(
  #       total_paid: self.quota_amount,
  #       date: index == 0 ? self.payment_date : 15.business_days.after(self.payments.order(date: :asc).pluck(:date).last),# n.days depending of selection in order
  #       status: :pending,
  #       latitude: self.latitude,
  #       longitude: self.longitude
  #     )
  #   end
  # end

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
