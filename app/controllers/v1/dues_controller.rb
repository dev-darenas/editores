module V1
  class DuesController < ApiController

    # GET /dues
    def index
      dues = Due.all
      json_response(dues)
    end

    private

  end
end
