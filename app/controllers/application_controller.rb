class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_404(params)
    Rails.logger.warn("Tried to access #{params} which did not exist.")
    render "layouts/404"
  end

  def stored_location_for(resource)
    nil
  end
   
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :avatar, :email, :height, :weight, :hand_orientation, :password, :password_confirmation, :current_password) }
  end
end
