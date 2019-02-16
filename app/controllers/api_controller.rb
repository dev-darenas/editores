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
      role:       user.roles.first.name
    }
  end

  def get_softpymes_config(user)
    { softpymes_id: user.softpymes_id, is_softpymes_synced: user.is_softpymes_synced }
  end

end