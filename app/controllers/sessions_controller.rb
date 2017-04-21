class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:email])
      # Logged in
    else
      # Login unsuccessfull
    end
  end

  def destroy
  end

  private

  def session_params
    params.require(:user).permit(:email,:password)
  end
end
