json.extract! inventory_transfer, :id, :sender_id, :recipient_id, :date, :product_id, :quantity, :observations, :created_at, :updated_at
json.url inventory_transfer_url(inventory_transfer, format: :json)
