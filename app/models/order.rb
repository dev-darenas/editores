class Order < ApplicationRecord
  belongs_to :country, required: false
  belongs_to :department, required: false
  belongs_to :city, required: false

  belongs_to :user, required: false

  # belongs_to :collector, required: false
  belongs_to :collector, :class_name => 'User', :foreign_key => 'collector_id'

  belongs_to :enterprise

  has_and_belongs_to_many :wares

  has_many :orders_wares
  has_many :payments, :dependent => :delete_all

  has_one :due

  # attr_accessible :title, :assets_attributes
  accepts_nested_attributes_for :orders_wares, allow_destroy: true
  accepts_nested_attributes_for :payments, allow_destroy: true

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
  validates :code, uniqueness: { scope: :enterprise_id }, on: :create

  # geocoded_by :address

  # reverse_geocoded_by :latitude, :longitude do |obj,results|
  #   if geo = results.first
  #     # obj.city    = geo.city
  #     # obj.zipcode = geo.postal_code
  #     # obj.country = geo.country_code
  #   end
  # end
  # after_validation :reverse_geocode

  # after_validation :geocode, :if => :address_changed?
  # before_validation :set_coords_to_nil, :if => :address_changed?
  # after_validation :geocode, if: -> (obj){  obj.department.present? and obj.city.present? and obj.address.present? and obj.address_changed? }
  # after_validation :lat_changed?

  # after_validation :geocode
  # after_validation :geocode, if: ->(obj){ obj.latitude.present? and obj.longitude.present? }
  # validates :latitude, :presence => {message: "Not a valid location on Google Maps, please check name address & country fields" }
  # after_create :create_payments

  enum status: [:pending, :returned, :completed, :lost]
  before_save :set_total
  $ARRAY_STATUS = { 
    pending: 'Pendiente',
    returned: 'Devolución',
    completed: 'Completado',
    lost: 'Perdido'
  }

  def set_total
    self.total = quota_quantity * quota_amount
  end

  def status_es
    $ARRAY_STATUS[self.status.to_sym]
  end

  def self.status_es(status)
    $ARRAY_STATUS[status.to_sym]
  end

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

  def update_total_payment
    self.update!(total_paid: self.payments.sum(:total_paid))
    self.completed! if total_paid >= total
  end

  def balance
    total - total_paid
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
