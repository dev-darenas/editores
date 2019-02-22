class Ware < ApplicationRecord

  validates :reference, presence: true
  validates :name, presence: true
  validates :quantity, presence: true
  validates :price, presence: true

  has_and_belongs_to_many :orders

end
