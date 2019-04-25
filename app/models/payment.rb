class Payment < ApplicationRecord
  belongs_to :order

  # enum status: [:payment, :total, :partial]

  scope :are_pending, -> { where(status: [:pending, :delayed]) }
  scope :today, -> { where(date: Date.today) }

  reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode
  after_create :set_total_payment

  enum kind: [:regular, :initial]

  def set_total_payment
    self&.order&.update_total_payment
  end

  def row_status
    return ""

    #TODO: porque este campo status??
    case status
    when "pending"
      "table-danger"
    when "paid"
      "table-success" 
    else
      ""
    end
  end

  def row_label
    case status
    when "pending"
      "Pendiente"
    when "paid"
      "Pagado" 
    else
      "Aplazado"
    end
  end
end
