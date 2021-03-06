class ProjectsController < ApplicationController
  load_and_authorize_resource
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    # @projects = Project.all
    if current_user.user_type == 'developer'
      @projects = current_user.projects.uniq
    else
      @projects = Project.all
    end
  end

  def newuser
    [params[:id2]].each do |i|
      u = User.find_by(id: i)
      @project.users.delete u
      b = Bug.where(fixer_id: i)
      b2 = b.where(project_id: @project.id)
      b2.update_all(fixer_id: nil)
    end

    redirect_to project_url(@project)
  end

  # GET /projects/1 or /projects/1.json
  def show
    # @specific_bugs = Bug.where(project_id :'1')
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
    @project = Project.new(project_params)
    params[:users]["id"].each do |i|
      if not i == ""
        @project.users << User.find_by(id: i)
      end
    end

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    params[:users]["id"].each do |i|
      if not i == ""
        @project.users << User.find_by(id: i)
      end
    end
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:title, :description, :id)
    end
end
