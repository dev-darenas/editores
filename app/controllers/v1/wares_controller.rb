module V1
  class WaresController < ApiController

    # GET /wares
    def index
      wares = Ware.all
      json_response(wares)
    end
  end
end
