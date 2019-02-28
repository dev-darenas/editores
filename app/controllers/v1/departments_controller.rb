module V1
  class DepartmentsController < ApiController
    before_action :set_department, only: :cities

    # GET /departments
    def index
      departments = Department.all
      json_response(departments)
    end

    def cities
      cities = @department.cities
      json_response(cities)
    end

    private

    def set_department
      @department = Department.find(params[:department_id])      
    end
  end
end
