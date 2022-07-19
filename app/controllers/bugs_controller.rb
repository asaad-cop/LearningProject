class BugsController < ApplicationController
  load_and_authorize_resource
  before_action :set_bug, only: %i[ show edit update destroy ]

  # GET /bugs or /bugs.json
  def index
    # @bugs = Bug.all
    if current_user
      if current_user.user_type == 'developer'
        @bugs = Bug.where(fixer_id: current_user.id)
      elsif current_user.user_type == 'qa'
        @bugs = Bug.where(user_id: current_user.id)
      else
        @bugs = Bug.all
      end
    end
  end

  # GET /bugs/1 or /bugs/1.json
  def show
    @bug
  end

  # GET /bugs/new
  def new
    @bug = Bug.new
  end

  # GET /bugs/1/edit
  def edit
    @bug
  end

  # POST /bugs or /bugs.json
  def create
    @bug = Bug.new(bug_params)
    @bug.user_id = current_user.id
    p = @bug.project
    i = @bug.fixer_id
    p.users << User.find_by(id: i)
    p.users << User.find_by(id: current_user.id)

    respond_to do |format|
      if @bug.save
        format.html { redirect_to bug_url(@bug), notice: "Bug was successfully created." }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bugs/1 or /bugs/1.json
  def update
    respond_to do |format|
      if @bug.update(bug_params)
        p = @bug.project
        i = @bug.fixer_id
        p.users << User.find_by(id: i)
        p.users << User.find_by(id: current_user.id)
        format.html { redirect_to bug_url(@bug), notice: "Bug was successfully updated." }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1 or /bugs/1.json
  def destroy
    @bug.destroy

    respond_to do |format|
      format.html { redirect_to bugs_url, notice: "Bug was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      @bug = Bug.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bug_params
      params.require(:bug).permit(:title, :description, :screenshot, :deadline, :bug_type, :status, :user_id, :project_id, :fixer_id)
    end
end
