class ToolsController < ApplicationController
  before_action :require_authentication, only: [:new, :create, :delete]
  def show
    @tool = Tool.find params[:id]
    @rental = Rental.new
  end

  def new
    @tool = Tool.new(owner: current_user, daily_rate: 0.00, deposit: 0.00)
  end

  def index
    @params = params # for debugging only
    tool_name = params[:tool]
    @result = Tool.where('name ILIKE ?', "%#{tool_name}%").where('availability = true')

    unless params[:lat].empty? && params[:lng].empty?
      @lat = params[:lat]
      @lng = params[:lng]
    end
  end

  def create
    tool = Tool.new(tool_params)
    tool.owner = current_user
    if tool.save
      flash[:success] = "Tool created!"
      redirect_to dashboard_path
    else
      @tool = tool
      render 'new'
    end
  end

  def delete
  end

  private

  def tool_params
    params.require(:tool).permit(:name,:description,:full_address,:lat,:lng,
      :daily_rate,:deposit_cents,:category_id, :picture)
  end
end


