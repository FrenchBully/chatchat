class SessionsController < Devise::SessionsController
	protected

  def after_sign_up_path_for(resource)
    '/users'
  end
end
