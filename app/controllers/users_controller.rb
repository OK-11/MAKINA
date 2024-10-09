class UsersController < ApplicationController

  def index
    @user = User.find_by(id: session[:user_id])
    if @user.projects.present?
      @project = @user.projects.last
      session[:project_id] = @project.id
      @project_missions = @project.project_missions.order(:position)
      @dashboard_status = 0

      if @project.project_missions.where(status: 1).present?
        @project_mission = @project.project_missions.where(status: 1).order(:position).first
      else
        @project_mission = @project.project_missions.where(status: 1).order(:position).last
      end

    else
      @project = nil
      @project_missions = nil
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.email = @user.email.downcase if @user.email.present?
    if @user.save
      session[:user_id] = @user.id
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)
    @user.email = @user.email.downcase if @user.email.present?
    if @user.save
      redirect_to users_path
    else
      render :edit
    end
  end

  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
