class DiscussionsController < ApplicationController
  before_action :set_project
  before_action :set_discussion, only: [:show, :destroy]
  before_action :authorize_admin, only: [:new, :create, :destroy]

  def new
    @discussion = @project.discussions.new
  end

  def create
    @discussion = @project.discussions.new(discussion_params)
    if @discussion.save
      redirect_to project_discussion_path(@project, @discussion), notice: "Discussion created!"
    else
      render :new
    end
  end

  def show
    @messages = @discussion.messages.includes(:user)
  end

  def destroy
    @discussion.destroy
    redirect_to project_path(@project), notice: "Discussion deleted!"
  end

  private
  
  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_discussion
    @discussion = @project.discussions.find_by(id: params[:id])
    redirect_to project_path(@project), alert: "Discussion not found!" unless @discussion
  end

  def authorize_admin
    unless current_user.has_role?(:admin) || current_user == @project.user
      redirect_to project_path(@project), alert: "Only project admins can create discussions."
    end
  end

  def discussion_params
    params.require(:discussion).permit(:title)
  end
end
