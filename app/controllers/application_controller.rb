class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?

  def logged_in?
    if session[:user_id]
      return true
    else
      return false
    end
  end
  
  private

  def login_with_credentials(email,password)
    user = User.find_by(email: email)
    if user && user.authenticate(password)
      create_session user
      return user
    else
      return nil
    end
  end

  def create_session(user)
    session[:user_id] = user.id
    session[:user_email] = user.email
  end


end
