class User < ApplicationRecord
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :firstname,
            :lastname,
            :cellphone,
            presence: true


  has_many  :sent,
            :class_name => "Ware",
            :foreign_key  => "sent_id"

  has_many  :received,
            :class_name => "Ware", 
            :foreign_key  => "received_id"


  # has_many  :collectors,
  #           :class_name => "Order",
  #           :foreign_key  => "collector_id"

  has_many :orders, :dependent => :destroy
  has_many :web_orders, :dependent => :destroy
  has_many :api_orders, :dependent => :destroy

  has_many :wares, through: :orders

  has_many :payments, through: :orders

  def full_name
    "#{firstname} #{lastname}"
  end

  def active_for_authentication?      
    super && roles.first.name == "admin"
  end

  def self.collector
    Role.find_by(name: :collector).users
  end
end
