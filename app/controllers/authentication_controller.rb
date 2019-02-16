class AuthenticationController < ApiController
  skip_before_action :authorize_request, only: [:authenticate, :social_network]
  
  # before_action :increment_login_counts, only: [:authenticate, :social_network, :validate_token]

  # return auth token once user is authenticated
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token, config: get_current_configuration, provider: 'email')
  end

  def validate_token
    auth_token = get_current_token
    config = get_current_configuration
    json_response(auth_token: auth_token, config: get_current_configuration, provider: 'email')
  end

  def social_network
    auth_token = 
      AuthenticateUserSocialNetwork.new(auth_params[:email], auth_params[:user_id], auth_params[:auth_token], auth_params[:provider]).call
    json_response(auth_token: auth_token, config: get_current_configuration, provider: auth_params[:provider])
  end

  private

  def auth_params
    params.permit(:email, :password, :user_id, :auth_token, :provider)
  end

  def increment_login_counts
    user = User.find_by_email(params[:email]) || current_user
    user.increment!(:sign_in_count) if user
  end

  # check for token in `Authorization` header
  def get_current_token
    if request.headers['Authorization'].present?
      return request.headers['Authorization'].split(' ').last
    end
      raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end