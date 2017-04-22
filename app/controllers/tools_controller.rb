class ToolsController < ApplicationController

	def show
    @tool = Tool.find params[:id]
    @rental = Rental.new
  end

	def index
		# @tool = Tool.all
	end

  def create
  end

  def delete
  end

end


