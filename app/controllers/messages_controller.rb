class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_discussion
    before_action :set_message, only: [:edit, :update, :destroy]
    before_action :authorize_user, only: [:edit, :update, :destroy]
  
    def create
      @message = @discussion.messages.build(message_params)
      @message.user = current_user
      if @message.save
        redirect_to project_discussion_path(@discussion.project, @discussion), notice: "Message posted!"
      else
        redirect_to project_discussion_path(@discussion.project, @discussion), alert: "Message can't be empty."
      end
    end
  
    def edit
    end
  
    def update
      if @message.update(message_params)
        redirect_to project_discussion_path(@discussion.project, @discussion), notice: "Message updated!"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @message.destroy
      redirect_to project_discussion_path(@discussion.project, @discussion), notice: "Message deleted!"
    end
  
    private
  
    def set_discussion
      @discussion = Discussion.find(params[:discussion_id])
    end
  
    def set_message
      @message = @discussion.messages.find(params[:id])
    end
  
    def authorize_user
      unless current_user == @message.user
        redirect_to project_discussion_path(@discussion.project, @discussion), alert: "Not authorized!"
      end
    end
  
    def message_params
      params.require(:message).permit(:content)
    end
  end
  