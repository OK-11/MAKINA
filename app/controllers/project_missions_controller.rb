class ProjectMissionsController < ApplicationController
  def show
    @user = User.find_by(id: session[:user_id])
    @project_mission = ProjectMission.find_by(id: params[:id])
    @mission = @project_mission.mission
    @project = @project_mission.project
    @project_mission_tasks = @project_mission.project_mission_tasks.order(:position)
    @project_missions = @project.project_missions.order(:position)
    @dashboard_status = @project_mission.id
  end
end
