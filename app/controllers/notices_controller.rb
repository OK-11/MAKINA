class NoticesController < ApplicationController
  def update
    notice = Notice.find_by(id: params[:id])
    notice.update(status: 2)
    comment = notice.comment
    project_mission_task = comment.project_mission_task
    
    redirect_to project_mission_task_comments_path(project_mission_task)
  end
end
