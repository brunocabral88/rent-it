module ApplicationHelper

  def current_is_previous_renter? (page_tool)
    current_user.rentals.each do |rental|
      rental.rental_items.each do |item|
        return true if item.tool == page_tool
      end
    end
    nil
  end

end
