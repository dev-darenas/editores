json.extract! payment, :id, :order_id, :total_paid, :date, :status, :created_at, :updated_at
json.url payment_url(payment, format: :json)
