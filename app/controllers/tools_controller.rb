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

        # pass data to view as JS
        result_json = @filtered_result.as_json
        result_json.each do |tool|
          tool_id = tool["id"]
          img_url = @result.find_by_id(tool_id).picture.url(:small)
          tool["img_url"] = img_url
        end
        gon.result = result_json
        gon.coordinate = { lat: params[:lat], lng: params[:lng] }

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

  def upload_tool_pic
      # @pic = params[:picture]
      # puts @pic
      render text: 'testinggg'
  end

  private

  def tool_params
    params.require(:tool).permit(:name,:description,:full_address,:lat,:lng,
      :daily_rate,:deposit_cents,:category_id, :picture)
  end
end


