class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

   def stored_location_for(resource)
     nil
   end
   
   def after_sign_in_path_for(resource)
     user_path(current_user.id)
   end



  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :avatar, :email, :height, :weight, :hand_orientation, :password, :password_confirmation, :current_password) }
  end
end
