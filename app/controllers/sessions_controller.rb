class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user.present? && @user.authenticate(params[:session][:password])
      if @user.position == 1
        session[:user_id] = @user.id
        redirect_to users_path
      else
        session[:user_id] = @user.id
        redirect_to admin_users_path
      end
    else
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_sessions_path
  end

end
