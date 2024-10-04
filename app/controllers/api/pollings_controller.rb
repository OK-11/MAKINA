class Api::PollingsController < ApplicationController
  def polling_mission
    user = User.find_by(id: session[:user_id])
    project = user.projects.find_by(id: session[:project_id])
    project_missions = project.project_missions.order(:position)
    respond_to do |format|
      format.json { render json: project_missions }
    end
  end

  def polling_task
    user = User.find_by(id: session[:user_id])
    project = user.projects.find_by(id: session[:project_id])
    project_mission = project.project_missions.find_by(id: params[:id])
    project_mission_tasks = project_mission.project_mission_tasks.order(:position)
    respond_to do |format|
      format.json { render json: project_mission_tasks }
    end
  end
end

