class MainController < ApplicationController
  before_action :require_authentication, only: [:dashboard]
  def index

  end

  def dashboard
    @user = current_user
  end
end
