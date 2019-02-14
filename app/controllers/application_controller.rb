class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  layout :layout_by_resource
  # before_action :authenticate


  def after_sign_in_path_for(resource)
      # if current_user.role == 'admin' || current_user.role == 'store_admin'
      #   admin_index_path
      # else
      #   root_path
      # end
  end



  private

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

end
