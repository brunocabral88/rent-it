class ToolsController < ApplicationController

  def show
    @tool = Tool.find params[:id]
    @rental = Rental.new
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
  end

  def delete
  end

end


