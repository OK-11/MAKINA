class CommentsController < ApplicationController

  before_action :check_user?, only: [:index]
  def index
  end

  def create
    user = User.find_by(id: session[:user_id])
    project_mission_task = ProjectMissionTask.find(params[:project_mission_task_id])
    comment = project_mission_task.comments.build(comment_params)
    comment.user_id = user.id
    if comment.save
      if user.position == 1
        to_users = User.where(position: 2)
        to_users.each do |to_user|
          Notice.create(comment_id: comment.id, user_id: to_user.id)
        end
        redirect_to project_mission_task_comments_path(project_mission_task)
      elsif user.admin == false
        to_client_user = project_mission_task.project_mission.project.user
        Notice.create(comment_id: comment.id, user_id: to_client_user.id)
        to_admin_users = User.where(admin: true)
        to_admin_users.each do |to_admin_user|
          Notice.create(comment_id: comment.id, user_id: to_admin_user.id)
        end
        redirect_to project_mission_task_comments_path(project_mission_task)
      else
        to_client_user = project_mission_task.project_mission.project.user
        Notice.create(comment_id: comment.id, user_id: to_client_user.id)
        to_worker_users = User.where(position: 2, admin: false)
        to_worker_users.each do |to_worker_user|
          Notice.create(comment_id: comment.id, user_id: to_worker_user.id)
        end
        redirect_to project_mission_task_comments_path(project_mission_task)
      end
      
    end
    
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def check_user?
    @project_mission_task = ProjectMissionTask.find_by(id: params[:project_mission_task_id])
    @project_mission = @project_mission_task.project_mission
    project = @project_mission.project
    client_user = project.user

    @user = User.find_by(id: session[:user_id])
    if @user.position == 1
      if client_user.id == @user.id
        @comments = @project_mission_task.comments
        @comment = Comment.new
      else
        redirect_to users_path
      end
    elsif @user.admin == true
      @comments = @project_mission_task.comments
      @comment = Comment.new
    end
  end

end
