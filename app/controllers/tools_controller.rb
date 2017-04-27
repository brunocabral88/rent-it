class ToolsController < ApplicationController

  def show
    @tool = Tool.find params[:id]
    @rental = Rental.new
  end

  def index

    if params[:start_date].blank? || params[:end_date].blank?
      flash.alert = 'Please enter start date and end date'
      redirect_to root_path
    elsif params[:tool].blank?
      flash.alert = 'Please enter a tool name'
      redirect_to root_path
    else
      @start_date = params[:start_date].to_date
      @end_date = params[:end_date].to_date
      session[:start_date] = params[:start_date]
      session[:end_date] = params[:end_date]
      @result = Tool.where('name ILIKE ?', "%#{params[:tool]}%")
                    .where('availability = true')
      if @result.count <= 0
        flash.notice = 'No tool found'
        redirect_to root_path
      else
        # filter result for with start and end date

        @filtered_result = @result.reject do |tool|

          latest_rental = tool.rentals.order(start_date: :desc)[0]
          if latest_rental
            (@start_date..@end_date).overlaps?(latest_rental.start_date..latest_rental.end_date)
          else
            false
          end
        end

        category_ids = @result.distinct(:category).pluck(:category_id)
        @categories = Category.find(category_ids);
      end
    end
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


