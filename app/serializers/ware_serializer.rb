class WareSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper

  attributes :id, :name, :reference, :price, :price_label

  def price_label
    number_to_currency(object.price)
  end
end
