class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      # Login user
      flash[:success] = 'Welcome, sucessfully registered!'
      create_session user
      redirect_to root_path
    else
      render new
    end
  end

  def dashboard

  end

  private 

  def user_params
    params.require(:user).permit(:name,:email,:phone,:password,:password_confirmation)
  end
end
