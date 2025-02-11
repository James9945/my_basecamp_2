class DiscussionsController < ApplicationController
    before_action :set_project
    before_action :authorize_admin, only: [:new, :create, :destroy]
    
  
    def new
      @discussion = @project.discussions.new
    end
  
   
    def create
        @discussion = @project.discussions.new(discussion_params)
        if @discussion.save
        redirect_to @project, notice: "Discussion created!"
        else
        render :new, status: :unprocessable_entity
        end
    end
  
    def destroy
      @discussion = @project.discussions.find(params[:id])
      @discussion.destroy
      redirect_to @project, notice: "Discussion deleted!"
    end
  
    private
  
    def set_project
      @project = Project.find(params[:project_id])
    end
  
    def authorize_admin
        unless current_user.has_role?(:admin) || current_user == @project.user
          redirect_to @project, alert: "Only project admins can create discussions."
        end
    end
      
  
    def discussion_params
      params.require(:discussion).permit(:title)
    end
  end
  