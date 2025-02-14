class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
  if resource.has_role?(:admin)
    admin_dashboard_index_path # Redirects admins to the admin panel
  else
    root_path
  end
end

end
