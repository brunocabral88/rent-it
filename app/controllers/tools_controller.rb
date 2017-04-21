class ToolsController < ApplicationController

  def show
    @tools = Tool.all
  end

	def index
		#@tool = Tool.find params[:id]
	end

  def create
  end

  def delete
  end

end


