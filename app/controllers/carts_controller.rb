class CartsController < ApplicationController
  include CartDeposit

  def show
    if cart.any?
      @tools = []
      cart.each do |tool_id|
        @tools << Tool.find(tool_id)
      end
    end
    @total_deposit = cart_deposit(@tools)
  end

  def add_item
    if !cart.include?(params[:tool_id])
      puts cart
      cart << params[:tool_id]
      flash[:success] = 'Item added to the cart!'
      redirect_to :back
    else
      flash[:info] = "Item already on cart"
      redirect_to :back
    end
  end

  def delete_item
    session[:cart_items].delete(params[:tool_id])
    flash[:info] = "Item deleted from cart"
    redirect_to cart_path
  end

end
