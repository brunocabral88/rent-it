class SessionsController < ApplicationController

  layout false, only: [:new]

  def new
    if current_user
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    if params[:user]
      # Classic login
      user = login_with_credentials(params[:user][:email],params[:user][:password]) 
      if user
        flash[:success] = "Welcome back, #{user.name}"
        redirect_to root_path
      else
        flash.now[:danger] = 'Invalid credentials'
        render 'new'
      end
    else
      # Facebook auth
      user = User.from_omniauth(env["omniauth.auth"])
      create_session user
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_email] = nil
    flash[:info] = 'Logged out!'
    redirect_to root_path
  end

  private

  def session_params
    params.require(:user).permit(:email,:password)
    # params.require(:)
  end
end
