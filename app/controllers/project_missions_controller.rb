class ProjectMissionsController < ApplicationController

  before_action :not_admin_user?,:project_mission_current_user?, only: [:show]
  
  def show
  end



  private

  def project_mission_current_user?
    @project_mission = ProjectMission.find_by(id: params[:id])
    @project = @project_mission.project
    @user = @project.user
    if @user.id == session[:user_id]
      @mission = @project_mission.mission
      @project_mission_tasks = @project_mission.project_mission_tasks.order(:position)
      @project_missions = @project.project_missions.order(:position)
      @dashboard_status = @project_mission.id
    else
      redirect_to users_path
    end
  end

end
