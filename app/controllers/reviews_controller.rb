class ReviewsController < ApplicationController
  before_filter :authorize_user

  def create

    @tool = Tool.find params[:tool_id]
    @review = @tool.reviews.new(review_params)
    @rental_item = find_rental_item_to_review(@tool)
    @review.rental_item = @rental_item
    # @review.user_id = current_user.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to tool_path(@tool), :notice => 'Review was successfully created.' }
      else
        puts @review.errors.messages
        format.html { render '/tools/show' }
      end
    end
  end

  def destroy

    @tool = Tool.find params[:tool_id]
    @review = Review.find params[:id]

    @review.destroy
    redirect_to tool_path(@tool)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def authorize_user
    if !current_user
      redirect_to root_path, notice: "Log in First!"
    end
  end

  def find_rental_item_to_review(tool)
    current_user.rentals.each do |rental|
      rental.rental_items.each do |rental_item|
        return rental_item if rental_item.tool == tool
      end
    end
    nil
  end
end
