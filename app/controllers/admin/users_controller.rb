class Admin::UsersController < ApplicationController
  
  #admin側でユーザを作る時は、positionは勝手に2になるようにする
  def index
    @users = User.where(position: 1).order(updated_at: :desc).page(params[:page]).per(10)
    @admins = User.where(admin: true).order(updated_at: :desc).page(params[:page]).per(10)
    @workers = User.where(position: 2, admin: false).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.email = @user.email.downcase if @user.email.present?
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.email = @user.email.downcase if @user.email.present?
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin, :position)
  end

end
