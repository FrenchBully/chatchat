class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # overrides the devise path for signed in user to location select  
  def after_sign_in_path_for(resource_or_scope)
     select_location_path
  end

  # overrides the devise path for signed out user to root
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
