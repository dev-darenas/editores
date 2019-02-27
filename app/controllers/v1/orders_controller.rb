module V1
  class OrdersController < ApiController
    before_action :set_order, only: [:show, :update, :destroy]

    # GET /orders
    def index
      orders = current_user.orders
      json_response(orders)
    end

    # POST /orders
    def create
      # account = current_user.accounts.create!(account_params)
      # json_response(account, :created)
    end

    # GET /orders/:id
    def show
      # json_response(@account)
    end

    # PUT /orders/:id
    def update
      # @account.update(account_params)
      # json_response(@account)
    end

    # DELETE /orders/:id
    def destroy
      # @account.destroy
      # json_response(@account)
    end

    def coordinates
      # orders = current_user.orders.near(params[:lat], params[:lng])
      orders = Order.near(
        [params[:lat], params[:long]]
      ).where(user_id: current_user.id).
      map { |e| {latitude: e.latitude.to_f, longitude: e.longitude.to_f} }

      json_response(orders)
    end

    private

    def account_params
      # whitelist acccout params
      params.permit(
        :name,
      )
    end

    def set_order
      @order = Order.find(params[:id])
    end
  end
end
