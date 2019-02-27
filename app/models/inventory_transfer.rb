class InventoryTransfer < ApplicationRecord

 belongs_to :sender,
            :class_name => "User",
            :foreign_key  => "sender_id"

 belongs_to :recipient,
            :class_name => "User",
            :foreign_key  => "recipient_id" 


 belongs_to :ware

 validates :sender,
           :recipient,
           :quantity,
           presence: true
end
