class RentalsController < ApplicationController

  def show
    @rental = Rental.find(params[:id])
  end

  def create
    charge = perform_stripe_deposit_charge
    rental  = create_order(charge)
    user_email = current_user.email

    if rental.valid?
      empty_cart

        # UserMailer.successful_order_email(user_email, order).deliver_now
puts rental
        redirect_to(rental_path(rental), notice: 'Your Order has been placed.')
      else
        redirect_to(cart_path, error: rental.errors.full_messages.first)
      end

  rescue Stripe::CardError => e
    redirect_to cart_path, error: e.message
  end

  def refund_and_total_charge
      # find the existing rental
      item = RentalItem.find(params[:rental_item_id])

      @deposit_rental = item.rental

      # if rental has a deposit charge, proceed to refund
      if @deposit_rental.stripe_charge_id
        refund = perform_stripe_refund(@deposit_rental)
      end

      # process the total charge
      total_charge = perform_stripe_total_charge
      rental  = create_order(total_charge)

      user_email = current_user.email


      if rental.valid?
        empty_cart

        # UserMailer.successful_order_email(user_email, order).deliver_now


        redirect_to(rental_path(rental), notice: 'Your Order has been placed.')

      else
        redirect_to(cart_path, error: rental.errors.full_messages.first)

      end

    rescue Stripe::CardError => e
      redirect_to cart_path, error: e.message
  end

  private

  def perform_stripe_deposit_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_deposit, # in cents
      description: "Rent-it Order deposit payment",
      currency:    'cad'
    )
  end

  def perform_stripe_total_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_total, # in cents
      description: "Rent-it Order total payment",
      currency:    'cad',
      card: @deposit_rental.stripe_card_id,
      customer: @deposit_rental.stripe_customer_id
    )
  end
  def perform_stripe_refund(rental)
    re = Stripe::Refund.create(
      charge: rental.stripe_charge_id
    )
  end

  def create_order(stripe_charge)
    rental = Rental.new(
      renter_id: current_user.id,
      total_cents: cart_deposit,
      stripe_charge_id: stripe_charge.id, # returned by stripe
      start_date: session[:start_date],
      end_date: session[:end_date],
      stripe_customer_id: stripe_charge.customer,   # returned by stripe
      stripe_card_id: stripe_charge.source.id      # returned by stripe
    )
    cart.each do |tool_id|
      if tool = Tool.find_by(id: tool_id)
        rental.rental_items.new(
          tool: tool,
        )
      end
    end
    if rental.start_date === nil || rental.end_date === nil
      flash[:notice] = "Please fill the start and end date fields"
    else
      puts "working"
      rental.save!

    end
    rental
  end

  def create_refund_and_total_charge(stripe_charge)
    rental = Rental.new(
      renter_id: current_user.id,
      total_cents: cart_total,
      stripe_charge_id: stripe_charge.id, # returned by stripe
      start_date: session[:start_date],
      end_date: session[:end_date]
    )
    cart.each do |tool_id|
      if tool = Tool.find_by(id: tool_id)
        rental.rental_items.new(
          tool: tool,
        )
      end
    end
    rental.save!
    rental
  end
  # returns total in cents not dollars (stripe uses cents as well)
  def cart_total
    total = 0

    @deposit_rental.rental_items.each do |tool_id|
      if t = Tool.find_by(id: tool_id)
        duration = (t.user.rental.end_date - t.user.rental.start_date).to_i
        total += t.daily_rate_cents * duration.to_i
      end
    end
    total
  end

  def cart_deposit
    total = 0
    cart.each do |tool_id|
      if t = Tool.find_by(id: tool_id)
        total += t.deposit_cents.to_i
      end
    end
    total
  end

  def refund_stripe_deposite_charge
    Stripe::Refund.create(
      charge: "stripe_charge_id"
    )
  end

end
