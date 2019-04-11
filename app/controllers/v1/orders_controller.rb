module V1
  class OrdersController < ApiController
    before_action :set_order, only: [:show, :update, :destroy]

    # GET /orders
    def index
      if current_user.has_role? :collector
        # orders = ApiOrder.where(collector_id: current_user.id, payment_date: Date.today)
        orders = ApiOrder.where("collector_id = ? AND payment_date <= ?", current_user.id, Date.today)
      else
        # orders = current_user.api_orders.near([params[:latitude], params[:longitude]]).where(payment_date: Date.today)
        orders = current_user.api_orders.where("payment_date <= ?", Date.today)
      end
      # orders = current_user.orders.where(payment_date: Date.today)
      json_response(orders)
    end

    # def orders
    #   orders = current_user.orders
    #   json_response(orders)
    # end

    # POST /orders
    def create
      # order = current_user.api_orders.new(order_params)
      order = ApiOrder.new(order_params)
      order.save!
      if params[:has_initial_payment]
        order.payments.create(
          total_paid: params[:initial_amount],
          date: params[:order][:date],
          kind: :initial,
          observations: 'Cuota Inicial',
          latitude: params[:order][:latitude],
          longitude: params[:order][:longitude]
        )
      end
      json_response(order, :created)
    end

    # GET /orders/:id
    def show
      # json_response(@account)
    end

    # PUT /orders/:id
    def update
      @order.update_attributes(status: params[:status])
      json_response(@order, :ok)
    end

    # DELETE /orders/:id
    def destroy
      # @account.destroy
      # json_response(@account)
    end

    def search
      orders = []
      if params[:query].present?
        orders = Order.where("code LIKE ?", "%#{params[:query]}%")
      end
      json_response(orders)
    end

    def coordinates
      orders = current_user.api_orders.where(payment_date: Date.today, status: :pending).near([params[:latitude], params[:longitude]]).
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
        :enterprise_id,
        :country_id,
        :collector_id,
        :user_id,
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
        ],
        payments_attributes: [
          :total_paid,
          :observations,
          :date,
          :latitude,
          :longitude
        ]
      )
    end
  end
end
