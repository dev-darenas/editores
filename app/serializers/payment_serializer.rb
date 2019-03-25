class PaymentSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper

  attributes :id, :order_id, :total_paid, :date, :status, :observations
  has_one :order

  def total_paid
    number_to_currency(object.total_paid)
  end
end
