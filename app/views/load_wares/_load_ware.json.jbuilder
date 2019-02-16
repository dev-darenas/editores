json.extract! load_ware, :id, :user_id, :ware_id, :quantity, :created_at, :updated_at
json.url load_ware_url(load_ware, format: :json)
