class Api::PollingsController < ApplicationController
  def polling_mission
    user = User.find_by(id: session[:user_id])
    project = user.projects.find_by(id: session[:project_id])
    tasks = []

    project_missions = project.project_missions.order(:position)

    if project.project_missions.where(status: 1).present?
      project_mission = project.project_missions.where(status: 1).order(:position).first
      mission_name = project_mission.mission.name
      if project.project_missions.where(status: 1).order(:position).first.project_mission_tasks.where(status: 1).present?
        project_mission_task = project.project_missions.where(status: 1).order(:position).first.project_mission_tasks.where(status: 1).order(:position).first
      else
        project_mission_task = project.project_missions.where(status: 1).order(:position).first.project_mission_tasks.order(:position).first
      end
      project_mission_tasks = project.project_missions.where(status: 1).order(:position).first.project_mission_tasks.order(:position)
      project_mission_tasks.each do |project_mission_task|
        tasks << project_mission_task.task.name
      end
      current_slide = tasks.index(project_mission_task.task.name)
    else
      project_mission = project.project_missions.order(:position).last
      mission_name = project_mission.mission.name
      if project.project_missions.order(:position).last.project_mission_tasks.where(status: 1).present?
        project_mission_task = project.project_missions.order(:position).last.project_mission_tasks.where(status: 1).order(:position).first
      else
        project_mission_task = project.project_missions.order(:position).last.project_mission_tasks.order(:position).first
      end
      project_mission_tasks = project.project_missions.order(:position).last.project_mission_tasks.order(:position)
      project_mission_tasks.each do |project_mission_task|
        tasks << project_mission_task.task.name
      end
      current_slide = tasks.index(project_mission_task.task.name)
    end

    respond_to do |format|
      format.json { render json: { project_missions: project_missions, project_mission_tasks: project_mission_tasks, tasks: tasks, mission_name: mission_name, current_slide: current_slide } }
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




  def carousel_mission
    user = User.find_by(id: session[:user_id])
    project = user.projects.find_by(id: session[:project_id])
    tasks = []

    if project.project_missions.where(status: 1).present?
      project_mission_tasks = project.project_missions.where(status: 1).order(:position).first.project_mission_tasks.order(:position)
      project_mission_tasks.each do |project_mission_task|
        tasks << project_mission_task.task.name
      end
    else
      project_mission_tasks = project.project_missions.order(:position).last.project_mission_tasks.order(:position)
      project_mission_tasks.each do |project_mission_task|
        tasks << project_mission_task.task.name
      end
    end
    respond_to do |format|
      format.json { render json: { project_mission_tasks: project_mission_tasks, tasks: tasks } }
    end
  end
end

