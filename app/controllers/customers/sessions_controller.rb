class Customers::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    session[:name] = resource.name
    flash[:notice] = "You have signed in successfully."
    root_path
  end
end
