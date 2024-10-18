class Admin::ProjectsController < ApplicationController

  before_action :admin_user_login?
  def new
    @user = User.find(params[:user_id])
    @project = Project.new
  end

  def create
    @user = User.find(params[:user_id])
    @project = @user.projects.build(project_params)
    if @project.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
    @project_missions = @project.project_missions.order(:position)
  end

  def edit
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
    if @project.update(project_params)
      redirect_to admin_user_project_path(@user, @project)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @project = @user.projects.find(params[:id])
    @project.destroy  
    redirect_to admin_users_path
  end


  private

  def project_params
    params.require(:project).permit(:name)
  end

end
