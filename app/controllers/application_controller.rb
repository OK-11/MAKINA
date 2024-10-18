class ApplicationController < ActionController::Base

  before_action :user_login?


  def user_login?
    unless session[:user_id].present?
      redirect_to new_sessions_path
    end
  end

  def user_logout?
    if session[:user_id].present?
      if User.find_by(id: session[:user_id]).position == 1
        redirect_to users_path
      elsif User.find_by(id: session[:user_id]).admin == true
        redirect_to admin_users_path
      end
    end
  end

  def admin_user_login?
    check_user = User.find_by(id: session[:user_id])
    if check_user.admin == false
      if check_user.position == 1
        redirect_to users_path
      end
    end
  end

  def not_admin_user?
    check_user = User.find_by(id: session[:user_id])
    if check_user.admin == true
      redirect_to admin_users_path
    end
  end

end
