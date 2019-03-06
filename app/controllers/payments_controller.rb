class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :destroy, :edit, :update]
  before_action :set_order, only: [:new, :create, :show, :index, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = current_user.orders.find(params[:order_id]).payments
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = @order.payments.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = @order.payments.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to order_payment_path(@order, @payment), notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to order_payment_path(@order, @payment), notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to order_payments_url(@order), notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def set_order
      @order = Order.find(params[:order_id] || params[:payment][:order_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:order_id, :total_paid, :date, :status, :observations)
    end
end
