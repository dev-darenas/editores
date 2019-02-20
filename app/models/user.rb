class User < ApplicationRecord
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :cellphone, presence: true


  has_many      :sent, 
                :class_name => "Ware",
                :foreign_key  => "sent_id"

  has_many      :received, 
                :class_name => "Ware", 
                :foreign_key  => "received_id"


  def full_name
    "#{firstname} #{lastname}"
  end
end
