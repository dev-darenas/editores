module V1
  class PaymentsController < ApiController
    before_action :set_payment, only: [:show, :update, :destroy]

    # GET /payments
    def index
      payments = current_user.payments.near([params[:latitude], params[:longitude]]).are_pending.today
      json_response(payments)
    end

    # POST /payments
    def create
      # payment = current_user.payments.create!(payment_params)
      # json_response(payment, :created)
    end

    # GET /payments/:id
    def show
      json_response(@payment)
    end

    # PUT /payments/:id
    def update
      distance = Geocoder::Calculations.distance_between(
        [params[:latitude],params[:longitude]],
        [@payment.latitude, @payment.longitude],
        units: :km
      )

      raise(ExceptionHandler::FarFromClient, Message.far_from_client) if distance > 0.5

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
      params.permit(
        :status,
        :date,
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
