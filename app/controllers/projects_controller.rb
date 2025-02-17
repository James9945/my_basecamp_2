class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :authorize_project_owner, only: [:edit, :update, :destroy]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @project = current_user.projects.build(project_params) # Associate project with user
  
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    @project = Project.find(params[:id])
    if @project.update(project_params.merge(user: current_user))
      redirect_to @project, notice: "Project updated successfully!"
    else
      render :edit
    end
  end
  
  

  def destroy
    if current_user.admin? || current_user == @project.user
      @project.destroy!
      redirect_to projects_path, notice: "Project was successfully deleted."
    else
      redirect_to projects_path, alert: "You are not authorized to delete this project."
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :user_id, attachments: [])
  end



  def set_project
    @project = Project.find(params[:id])
  end

  def authorize_project_owner
    unless current_user.admin? || current_user == @project.user
      redirect_to projects_path, alert: "You are not authorized to edit this project."
    end
  end
end
