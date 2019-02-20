class InventoryTransferSerializer < ActiveModel::Serializer
  attributes :id, :date, :quantity, :observations
  has_one :sender
  has_one :recipient
  has_one :product
end
