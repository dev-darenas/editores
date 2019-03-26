class ApiController < ActionController::API
  include Response
  include ExceptionHandler

  attr_reader :current_user #:current_org_group

  # called before every action on controllers
  before_action :authorize_request
  # attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

  def pagination_params
    { page: params[:page], per_page: params[:per_page] }
  end

  def pagination_dict(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.previous_page,
      total_pages: collection.total_pages,
      total_count: collection.total_entries
    }
  end

  def get_current_configuration
    user = User.find_by_email(params[:email]) || @current_user
    {
      role:         user.roles.first.name,
      current_user: ActiveModelSerializers::SerializableResource.new(user, serializer: UserSerializer).as_json,
      countries:    ActiveModelSerializers::SerializableResource.new(Country.all, each_serializer: CountrySerializer).as_json,
      products:     ActiveModelSerializers::SerializableResource.new(Ware.all, each_serializer: WareSerializer).as_json,
      dues:         ActiveModelSerializers::SerializableResource.new(Due.all, each_serializer: DueSerializer).as_json,
      enterprises:  ActiveModelSerializers::SerializableResource.new(Enterprise.all, each_serializer: EnterpriseSerializer).as_json,
      assesors:     ActiveModelSerializers::SerializableResource.new(User.all, each_serializer: UserSerializer).as_json,
      collectors:   ActiveModelSerializers::SerializableResource.new(User.with_role(:collector), each_serializer: UserSerializer).as_json
    }
  end
end