class OrdersWare < ApplicationRecord
  belongs_to :order
  belongs_to :ware
end
