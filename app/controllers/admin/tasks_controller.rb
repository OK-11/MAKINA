class Admin::TasksController < ApplicationController

  before_action :admin_user_login?

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to admin_tasks_path
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to admin_tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.check_foreign_key(ProjectMissionTask, "task_id")
      @task.destroy
      redirect_to admin_tasks_path
    else
      flash[:alert] = "その小タスクは使用されているため削除できません"
      redirect_to admin_tasks_path
    end
  end




  private

  def task_params
    params.require(:task).permit(:name)
  end
end
