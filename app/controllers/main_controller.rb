class MainController < ApplicationController
  before_action :require_authentication, only: [:dashboard]
  def index

  end

  def dashboard
    # This will query for every rental this user was the owner of the tools
    sql = "SELECT DISTINCT rentals.* FROM rentals 
      INNER JOIN rental_items ON (rental_items.rental_id = rentals.id) 
      INNER JOIN tools ON (rental_items.tool_id = tools.id) 
      INNER JOIN users ON (users.id = tools.owner_id) 
      WHERE users.id = #{current_user.id} AND rentals.returned = false
      ORDER BY rentals.id"
    result = ActiveRecord::Base.connection.execute(sql)
    @rentals_not_returned_this_user = []
    result.each { |rental| @rentals_not_returned_this_user << rental  } 
    @user = current_user
  end

  def get_renter_name_by_rental_id(id)
    rent = Rental.find_by(id: id)
    name = rent.renter.name
  end
  helper_method :get_renter_name_by_rental_id
end
