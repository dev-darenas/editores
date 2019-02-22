class Order < ApplicationRecord
  belongs_to :department
  belongs_to :city

  belongs_to :user, required: false
  has_and_belongs_to_many :wares

  has_many :orders_wares

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


  
  

end
