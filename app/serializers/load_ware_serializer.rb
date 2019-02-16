class LoadWareSerializer < ActiveModel::Serializer
  attributes :id, :quantity
  has_one :user
  has_one :ware
end
