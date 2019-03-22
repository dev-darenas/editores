module V1
  class EnterprisesController < ApiController

    # GET /countries
    def index
      enterprises = Enterprise.all
      json_response(enterprises)
    end
  end
end
