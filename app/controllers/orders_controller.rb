class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :return]
  helper_method :sort_column, :sort_direction

  # GET /orders
  # GET /orders.json
  def index
    @q = Order.ransack(params[:q])
    @orders = @q.result.includes(:collector, :user).paginate(page: params[:page], per_page: params[:per_page] || 10)

    respond_to do |format|
      format.html
      format.xlsx {
        response.headers[
          'Content-Disposition'
        ] = "attachment; filename=pedidos.xlsx"
      }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.orders_wares.build
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find params[:id]
    @order.orders_wares
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = WebOrder.new(order_params)
    respond_to do |format|
      if @order.save
        @order.payments.create(total_paid: params[:initial], kind: :initial, date: @order.date) if params[:initial] && params[:initial].to_i != 0
        format.html { redirect_to order_path(@order.id), notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { redirect_to new_order_path }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        params[:order][:orders_wares_attributes].each do | item |
          product = OrdersWare.find(item[1][:id])
          product.update_attributes(quantity: item[1][:quantity], total: item[1][:total], observations: item[1][:observations])
        end
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def return
    @order.returned!
    redirect_to edit_order_path(@order)
  end

  def transfer
    @error_codes = ""
    @success_codes = nil
    if params[:transfer]
      params[:transfer][:codes].tr(' ', '').split(",").each do |code|
        order = Order.find_by(code: code)
        @error_codes = code + ", " if order.nil?
        order.update(collector_id: params[:transfer][:user]) if order
      end

      @success_codes = "Ordenes actualizadas"
    end
  end

  def update_status
    @error_codes = ""
    @success_codes = nil
    if params[:transfer]
      params[:transfer][:codes].tr(' ', '').split(",").each do |code|
        order = Order.find_by(code: code)
        order.update!(status: params[:transfer][:status])
        @error_codes = code + ", " if order.nil?
      end

      @success_codes = "Ordenes actualizadas"
    end
  end

  def update_date_payment
    @error_codes = ""
    @success_codes = nil
    if params[:order]
      params[:order][:codes].tr(' ', '').split(",").each do |code|
        order = Order.find_by(code: code)
        order.update!(order_params) if order
        @error_codes = code + ", " if order.nil?
      end

      @success_codes = "Ordenes actualizadas"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(
        :code,
        :enterprise_id,
        :due_id,
        :country_id,
        :user_id,
        :collector_id,
        :department_id,
        :city_id,
        :date,
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
        orders_wares_attributes: [
          :id,
          :ware_id,
          :quantity,
          :total,
          :observations
        ]
      )
    end
end
