class AttachmentsController < ApplicationController
    before_action :set_project
    before_action :authorize_user, only: [:create, :destroy]
  
    def create
      @attachment = @project.attachments.new(attachment_params)
      if @attachment.save
        redirect_to @project, notice: "Attachment added!"
      else
        redirect_to @project, alert: "Failed to add attachment."
      end
    end
  
    def destroy
      @attachment = @project.attachments.find(params[:id])
      @attachment.destroy
      redirect_to @project, notice: "Attachment removed!"
    end
  
    private
  
    def set_project
      @project = Project.find(params[:project_id])
    end
  
    def authorize_user
      unless @project.users.include?(current_user)
        redirect_to @project, alert: "Not authorized!"
      end
    end
  
    def attachment_params
      params.require(:attachment).permit(:file)
    end
  end
  