module V1
  class PaymentsController < ApiController
    before_action :set_payment, only: [:show, :update, :destroy]

    # GET /payments
    def index
      # payments = current_user.payments.near([params[:latitude], params[:longitude]]).today
      orders = current_user.orders.near([params[:latitude], params[:longitude]])  .where(payment_date: Date.today, status: :pending)
      json_response(orders)
    end

    # POST /payments
    def create
      payment = Payment.new(payment_params)
      payment.date = Date.today
      payment.save
      order = payment.order.update!(
        payment_date: params[:payment_date]
        # status: order.check_status
      )
      json_response(payment, :created)
    end

    # GET /payments/:id
    def show
      json_response(@payment)
    end

    # PUT /payments/:id
    def update
      distance = Geocoder::Calculations.distance_between(
        [params[:latitude],params[:longitude]],
        [@payment.latitude, @payment.longitude]
      )

      # raise(ExceptionHandler::FarFromClient, Message.far_from_client) if distance > 0.5

      @payment.update(payment_params)
      json_response(@payment)
    end

    # DELETE /payments/:id
    def destroy
      # @payment.destroy
      # json_response(@payment)
    end

    private

    def payment_params
      # whitelist acccout params
      params.require(:payment).permit(
        :order_id,
        :total_paid,
        :observations,
        :latitude,
        :longitude
      )
    end

    def set_payment
      @payment = Payment.find(params[:id])
    end
  end
end
