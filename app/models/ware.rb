class Ware < ApplicationRecord

  validates :reference,
            :name,
            :quantity,
            :price,
            presence: true

  has_and_belongs_to_many :orders

end
