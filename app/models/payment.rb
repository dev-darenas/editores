class Payment < ApplicationRecord
  belongs_to :order

  enum status: [:pending, :paid, :delayed]

  scope :are_pending, -> { where(status: [:pending, :delayed]) }
  scope :today, -> { where(date: Date.today) }

  reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode

  def row_status
    case status
    when "pending"
      "table-danger"
    when "paid"
      "table-success" 
    else
      ""
    end
  end
end
