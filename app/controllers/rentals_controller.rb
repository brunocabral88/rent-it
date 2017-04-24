class RentalsController < ApplicationController

  def show
    @rental = Rental.find(params[:id])
  end

  def create
    charge = perform_stripe_deposit_charge
    order  = create_order(charge)
    user_email = create_order(charge).email

    respond_to do |format|
      if order.valid?
        empty_cart!

        # UserMailer.successful_order_email(user_email, order).deliver_now


        format.html { redirect_to(rental, notice: 'Your Order has been placed.') }

      else
        # this cart_path should be made by Bruno's code
        format.html { redirect_to(cart_path, error: rental.errors.full_messages.first) }

      end

    end

  rescue Stripe::CardError => e
    # this cart_path should be made by Bruno's code
    redirect_to cart_path, error: e.message
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_deposit_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      tools.deposit_cents, # in cents
      description: "Rent-it Order deposit payment",
      currency:    'cad'
    )
  end

  def perform_stripe_total_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      duration:    (rentals.end_date - rentals.start_date).to_i,
      amount:      tools.daily_rate_cents * duration, # in cents
      description: "Rent-it Order deposit payment",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    rental = Rental.new(
      renter_id: current_user.id,
      total_cents: tools.deposit_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
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
    cart.each do |tool_id|
      if t = Tool.find_by(id: tool_id)
        total += t.daily_rate_cents.to_i
      end
    end
    total
  end

end
