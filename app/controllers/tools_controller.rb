class ToolsController < ApplicationController

  def show
    @tool = Tool.find params[:id]
    @rental = Rental.new
  end

  def index
    @params = params # for debugging only
    tool_name = params[:tool]
    @result = Tool.where('name ILIKE ?', "%#{tool_name}%").where('availability = true')

    category_ids = @result.distinct(:category).pluck(:category_id)
    @categories = Category.find(category_ids);
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


