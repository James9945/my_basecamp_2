class AdminDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin  # This calls the method below

  def index
    @users = User.all
  end

  def update_role
    user = User.find(params[:id])

    if params[:role] == "admin"
      user.add_role(:admin)
    elsif params[:role] == "remove_admin"
      user.remove_role(:admin)
    end

    if user.save  # Ensure role update is saved
      flash[:notice] = "#{user.email} role updated successfully."
    else
      flash[:alert] = "Failed to update role."
    end

    redirect_to admin_dashboard_index_path
  end

  

  private  # Ensure this is here

  def authorize_admin
    redirect_to root_path, alert: "Access denied." unless current_user.has_role?(:admin)
  end

end

