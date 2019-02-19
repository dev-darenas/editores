class Ware < ApplicationRecord

  validates :reference, presence: true
  validates :name, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
end
