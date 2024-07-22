class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address, :city, :postal_code, :phone, :province_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address, :city, :postal_code, :phone, :province_id])
  end

  def after_sign_in_path_for(resource)
    session[:name] = resource.name
    flash[:notice] = "You have signed in successfully."
    root_path
  end
end
