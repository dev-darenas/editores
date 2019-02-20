class LoadWaresController < ApplicationController
  before_action :set_load_ware, only: [:show, :edit, :update, :destroy]

  # GET /load_wares
  # GET /load_wares.json
  def index
    @load_wares = LoadWare.all
  end

  # GET /load_wares/1
  # GET /load_wares/1.json
  def show
  end

  # GET /load_wares/new
  def new
    @load_ware = LoadWare.new
  end

  # GET /load_wares/1/edit
  def edit
  end

  # POST /load_wares
  # POST /load_wares.json
  def create
    @load_ware = LoadWare.new(load_ware_params)

    respond_to do |format|
      if @load_ware.save
        format.html { redirect_to @load_ware, notice: 'Load ware was successfully created.' }
        format.json { render :show, status: :created, location: @load_ware }
      else
        format.html { render :new }
        format.json { render json: @load_ware.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /load_wares/1
  # PATCH/PUT /load_wares/1.json
  def update
    respond_to do |format|
      if @load_ware.update(load_ware_params)
        format.html { redirect_to @load_ware, notice: 'Load ware was successfully updated.' }
        format.json { render :show, status: :ok, location: @load_ware }
      else
        format.html { render :edit }
        format.json { render json: @load_ware.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /load_wares/1
  # DELETE /load_wares/1.json
  def destroy
    @load_ware.destroy
    respond_to do |format|
      format.html { redirect_to load_wares_url, notice: 'Load ware was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_load_ware
      @load_ware = LoadWare.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def load_ware_params
      params.require(:load_ware).permit(:user_id, :ware_id, :quantity, :observations)
    end
end
