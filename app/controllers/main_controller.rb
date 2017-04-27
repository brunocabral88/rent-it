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

    # Get user's total earnings for the last six months 
    rentals_owned = []
    @graph_data = []
    current_user.tools.map do |tool|
      tool.rentals.where('end_date > ?',[6.month.ago]).each do |rental|
        rentals_owned << rental
      end
    end
    puts "Rental id: #{rentals_owned}"
    rentals_as_user = Rental.where('end_date > ?',[6.month.ago]).where(renter: current_user)
    puts "Rentals as user #{rentals_as_user}"
    days = rentals_owned.map { |rental| rental.end_date }
    rentals_as_user.map { |rental| days << rental.end_date }
    days.map do |day|
      temp_hash = { day: day, user_data: 0, owner_data: 0 }
      rentals_as_user.each { |r| temp_hash[:user_data] += (r.end_date == day ? r.total_cents.to_f / 100 : 0) }
      rentals_owned.each { |r| temp_hash[:owner_data] += (r.end_date == day ? r.total_cents.to_f / 100 : 0 )}
      @graph_data << temp_hash
    end
    @data = [
      { y: '2009', a: 75,  b: 65 },
      { y: '2010', a: 50,  b: 40 },
      { y: '2010', a: 50,  b: 40 },
      { y: '2012', a: 100, b: 90 }
    ]
    # debug
    # days.map do |day|
    #   rentals_as_user.select { }
    # end
    
    # 0..5.times do |n|
    #   total_cents_for_the_month = user_tools.rentals.where('end_date < ?',[n.month.ago]).where('end_date > ?',[(n+1).month.ago]).sum(:total_cents)

    # end

    @user = current_user
  end

  def get_renter_name_by_rental_id(id)
    rent = Rental.find_by(id: id)
    name = rent.renter.name
  end
  helper_method :get_renter_name_by_rental_id
end
