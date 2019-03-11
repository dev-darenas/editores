module V1
  class OrdersController < ApiController
    before_action :set_order, only: [:show, :update, :destroy]

    # GET /orders
    def index
      orders = current_user.orders.where(payment_date: Date.today)
      json_response(orders)
    end

    # def orders
    #   orders = current_user.orders
    #   json_response(orders)
    # end

    # POST /orders
    def create
      order = current_user.orders.new(order_params)
      order.save!
      json_response(order, :created)
    end

    # GET /orders/:id
    def show
      # json_response(@account)
    end

    # PUT /orders/:id
    def update
      @order.update(order_params)
      json_response(@order, :ok)
    end

    # DELETE /orders/:id
    def destroy
      # @account.destroy
      # json_response(@account)
    end

    def coordinates
      orders = current_user.orders.near([params[:latitude], params[:longitude]]).
      map { |e| {latitude: e.latitude.to_f, longitude: e.longitude.to_f} }

      json_response(orders)
    end

    private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(
        :code,
        :country_id,
        :department_id,
        :city_id,
        :date,
        :status,
        :client_name,
        :client_phone,
        :spouse_name,
        :spouse_phone,
        :address_one,
        :neighborhood_address_one,
        :address_two,
        :neighborhood_address_two,
        :familiar_reference,
        :familiar_reference_phone,
        :personal_reference,
        :personal_reference_phone,
        :payment_date,
        :observations,
        :quota_quantity,
        :quota_amount,
        :total_paid,
        :latitude,
        :longitude,
        :due_id,
        orders_wares_attributes: [
          :ware_id,
          :quantity,
          :total,
          :observations
        ]
      )
    end
  end
end
