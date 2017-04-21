class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if login_with_credentials(params[:user][:email],params[:user][:password])
      flash[:success] = 'Welcome back, #{user.name}'
      redirect_to root_path
    else
      render 'new'
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
  end
end
