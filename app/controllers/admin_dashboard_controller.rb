class AdminDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @users = User.all
    @projects = Project.all
  end

  private

  def authorize_admin
    redirect_to root_path, alert: "Access denied!" unless current_user.has_role?(:admin)
  end
end
