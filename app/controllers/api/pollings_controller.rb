class Api::PollingsController < ApplicationController
  
  def polling_mission
    user = User.find_by(id: session[:user_id])
    project = user.projects.find_by(id: session[:project_id])
    tasks = []
    project_mission_task_ids = []
    project_mission_task_roles = []

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
        project_mission_task_ids << project_mission_task.id
        project_mission_task_roles << project_mission_task.role_display
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
        project_mission_task_ids << project_mission_task.id
        project_mission_task_roles << project_mission_task.role_display
      end

      current_slide = tasks.index(project_mission_task.task.name)
    end

    respond_to do |format|
      format.json { render json: { project_missions: project_missions, project_mission_tasks: project_mission_tasks, tasks: tasks, mission_name: mission_name, current_slide: current_slide, project_mission_task_ids: project_mission_task_ids, project_mission_task_roles: project_mission_task_roles  } }
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


  def user_notice
    notices = Notice.where(status: 1, user_id: session[:user_id]).order(created_at: :desc)
    if notices.present?
      notice_ids = []
      comments = []
      indexs = []
      notices.each do |notice|
        notice_ids << notice.id
        comments << notice.comment
        indexs[indexs.length] = indexs.length
      end

      project_mission_tasks = []
      from_user_names = []
      comments.each do |comment|
        project_mission_tasks << comment.project_mission_task
        from_user_names << comment.user.name
      end

      task_names = []
      mission_names = []
      project_mission_tasks.each do |project_mission_task|
        mission_names << project_mission_task.project_mission.mission.name
        task_names << project_mission_task.task.name
      end
      respond_to do |format|
        format.json { render json: { notices: true, from_user_names: from_user_names, mission_names: mission_names, task_names: task_names, indexs: indexs, notice_ids: notice_ids } }
      end
    else
      respond_to do |format|
        format.json { render json: { notices: false }}
      end
    end
  end
end

