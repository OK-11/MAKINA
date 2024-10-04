class Admin::MissionsController < ApplicationController
  def index
    @missions = Mission.all
  end

  def new
    @mission = Mission.new
  end

  def create
    @mission = Mission.new(mission_params)
    if @mission.save
      redirect_to admin_missions_path
    else
      render :new
    end
  end

  def edit
    @mission = Mission.find(params[:id])
  end

  def update
    @mission = Mission.find(params[:id])
    if @mission.update(mission_params)
      redirect_to admin_missions_path
    else
      render :edit
    end
  end

  def destroy
    @mission = Mission.find(params[:id])
    if @mission.check_foreign_key(ProjectMission, "mission_id")
      @mission.destroy
      redirect_to admin_missions_path
    else
      flash[:alert] = "その大タスクは使用されているため削除できません"
      redirect_to admin_missions_path
    end
  end





  private

  def mission_params
    params.require(:mission).permit(:name)
  end
end
