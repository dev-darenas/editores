module V1
  class CountriesController < ApiController

    # GET /countries
    def index
      countries = Country.all
      json_response(countries)
    end
  end
end
