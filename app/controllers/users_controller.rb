class UsersController < ApplicationController

  skip_before_action :user_login?, only: [:new, :create]
  before_action :user_logout?, only: [:new, :create]
  before_action :current_user?, only: [:edit, :update]
  before_action :not_admin_user?, only: [:index,:edit, :update]


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
  end

  def update
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

  def current_user?
    if params[:id].to_i == session[:user_id]
      @user = User.find_by(id: params[:id])
    else
      redirect_to edit_user_path(session[:user_id])
    end
  end


end
