class InventoryTransfersController < ApplicationController
  before_action :set_inventory_transfer, only: [:show, :edit, :update, :destroy]

  # GET /inventory_transfers
  # GET /inventory_transfers.json
  def index
    @inventory_transfers = InventoryTransfer.all
  end

  # GET /inventory_transfers/1
  # GET /inventory_transfers/1.json
  def show
  end

  # GET /inventory_transfers/new
  def new
    @inventory_transfer = InventoryTransfer.new
  end

  # GET /inventory_transfers/1/edit
  def edit
  end

  # POST /inventory_transfers
  # POST /inventory_transfers.json
  def create
    @inventory_transfer = InventoryTransfer.new(inventory_transfer_params)

    respond_to do |format|
      if @inventory_transfer.save
        format.html { redirect_to @inventory_transfer, notice: 'Inventory transfer was successfully created.' }
        format.json { render :show, status: :created, location: @inventory_transfer }
      else
        format.html { render :new }
        format.json { render json: @inventory_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inventory_transfers/1
  # PATCH/PUT /inventory_transfers/1.json
  def update
    respond_to do |format|
      if @inventory_transfer.update(inventory_transfer_params)
        format.html { redirect_to @inventory_transfer, notice: 'Inventory transfer was successfully updated.' }
        format.json { render :show, status: :ok, location: @inventory_transfer }
      else
        format.html { render :edit }
        format.json { render json: @inventory_transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_transfers/1
  # DELETE /inventory_transfers/1.json
  def destroy
    @inventory_transfer.destroy
    respond_to do |format|
      format.html { redirect_to inventory_transfers_url, notice: 'Inventory transfer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inventory_transfer
      @inventory_transfer = InventoryTransfer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inventory_transfer_params
      params.require(:inventory_transfer).permit(:sender_id, :recipient_id, :date, :ware_id, :quantity, :observations)
    end
end
