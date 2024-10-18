class Admin::ProjectMissionsController < ApplicationController

  before_action :admin_user_login?
  
  def new
    @user = User.find_by(id: params[:user_id])
    @project = @user.projects.find_by(id: params[:project_id])
    @project_mission = ProjectMission.new

    if @project.missions
      mission_ids = []
      @project.missions.each do |mission|
        mission_ids << mission.id
      end
      @missions = Mission.where.not(id: mission_ids)
    else
      @missions = Mission.all
    end
  end

  def create
    @user = User.find_by(id: params[:user_id])
    @project = @user.projects.find_by(id: params[:project_id])

    if params[:project_mission].present?
      mission_orders = project_mission_params[:orders].split(",").map(&:to_i)

      ActiveRecord::Base.transaction do
        mission_orders.each do |mission_id|
          project_mission = @project.project_missions.build(mission_id: mission_id)
          #acts_as_listによって、postion値がリスト内の最後の値になる
          unless project_mission.save
            raise ActiveRecord::Rollback
          end
        end
      end
      #例外が発生した場合はロールバックする
      redirect_to admin_user_project_path(@user, @project)
    else
      redirect_to admin_user_project_path(@user, @project)
    end
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @project = @user.projects.find_by(id: params[:project_id])
    @project_mission = @project.project_missions.find_by(id: params[:id])
    @mission = @project_mission.mission

    @project_mission_tasks = @project_mission.project_mission_tasks.order(:position)
  end

  def update
    @user = User.find_by(id: params[:user_id])
    @project = @user.projects.find_by(id: params[:project_id])
    @project_mission = @project.project_missions.find_by(id: params[:id])
    @project_mission.update(status: project_mission_params[:status])
    if @project_mission.save
      redirect_to admin_user_project_path(@user, @project)
    else
      redirect_to admin_user_project_path(@user, @project)
    end
  end

  def destroy
    @user = User.find_by(id: params[:user_id])
    @project = @user.projects.find_by(id: params[:project_id])
    @project_missions = @project.project_missions
    @project_missions.destroy_all
    redirect_to admin_user_project_path(@user, @project)
  end




  
  private

  def project_mission_params
    params.require(:project_mission).permit(:orders , :status)
  end

end
