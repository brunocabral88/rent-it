class CartsController < ApplicationController
  include CartDeposit

  def show
    if cart.any?
      @tools = []
      @total = 0
      cart.each do |tool_id,value|
        tool = Tool.find(tool_id)
        @tools << tool
        @total += tool.daily_rate_cents * (Date.parse(value["end_date"]) - Date.parse(value["start_date"])).to_i
      end
      @total_deposit = cart_deposit(@tools)
    end
  end

  def add_item
    if cart.has_key?(params[:tool_id])
      flash[:info] = "Item already on cart"
      redirect_to :back
      return
    end
    cart[params[:tool_id]] = { start_date: params[:start_date], end_date: params[:end_date] } 
    flash[:success] = 'Item added to the cart!'
    redirect_to :back
  end

  def delete_item
    session[:cart_items].delete(params[:tool_id])
    flash[:info] = "Item deleted from cart"
    redirect_to cart_path
  end
end