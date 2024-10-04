class Admin::ProjectMissionTasksController < ApplicationController
  def new
    @user = User.find_by(id: params[:user_id])
    @project = @user.projects.find_by(id: params[:project_id])
    @project_mission = @project.project_missions.find_by(id: params[:project_mission_id])
    @project_mission_task = ProjectMissionTask.new

    if @project_mission.tasks
      task_ids = []
      @project_mission.tasks.each do |task|
        task_ids << task.id
      end
      @tasks = Task.where.not(id: task_ids)
    else
      @tasks = Task.all
    end
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @project = @user.projects.find_by(id: params[:project_id])
    @project_mission = @project.project_missions.find_by(id: params[:project_mission_id])

    if params[:project_mission_task].present?
      task_positions = project_mission_task_params[:positions].split(",").map(&:to_i)

      ActiveRecord::Base.transaction do
        task_positions.each do |task_id|
          project_mission_task = @project_mission.project_mission_tasks.build(task_id: task_id)
          project_mission_task.role = 1
          #とりあえず1にしておく
          #acts_as_listによって、postion値がリスト内の最後の値になる
          unless project_mission_task.save
            raise ActiveRecord::Rollback
          end
        end
      end
      redirect_to admin_user_project_project_mission_path(@user,@project,@project_mission)
    else
      redirect_to admin_user_project_project_mission_path(@user,@project,@project_mission)
    end
  end

  def update
    @user = User.find_by(id: params[:user_id])
    @project = @user.projects.find_by(id: params[:project_id])
    @project_mission = @project.project_missions.find_by(id: params[:project_mission_id])
    @project_mission_task = @project_mission.project_mission_tasks.find_by(id: params[:id])
    @project_mission_task.update(status: project_mission_task_params[:status], role: project_mission_task_params[:role])
    if @project_mission_task.save
      if @project_mission.project_mission_tasks.where(status: 1).present?
      else
        @project_mission.update(status: 2)
        @project_mission.save
      end
      redirect_to admin_user_project_project_mission_path(@user,@project,@project_mission)
    else
      redirect_to admin_user_project_project_mission_path(@user,@project,@project_mission)
    end
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    @project = @user.projects.find_by(id: params[:project_id])
    @project_mission = @project.project_missions.find_by(id: params[:project_mission_id])
    @project_mission_tasks = @project_mission.project_mission_tasks
    @project_mission_tasks.destroy_all
    redirect_to admin_user_project_project_mission_path(@user,@project,@project_mission)
  end


  private

  def project_mission_task_params
    params.require(:project_mission_task).permit(:positions, :status, :role)
  end


end
