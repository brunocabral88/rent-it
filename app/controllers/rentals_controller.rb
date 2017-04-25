class RentalsController < ApplicationController

  def show
    @rental = Rental.find(params[:id])
  end

  def create
    charge = perform_stripe_deposit_charge
    rental  = create_order(charge)
    user_email = current_user.email

    respond_to do |format|
      if rental.valid?
        empty_cart!

        # UserMailer.successful_order_email(user_email, order).deliver_now


        format.html { redirect_to(rental_path(rental), notice: 'Your Order has been placed.') }

      else
        format.html { redirect_to(cart_path, error: rental.errors.full_messages.first) }

      end

    end

  rescue Stripe::CardError => e
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
      amount:      cart_deposit, # in cents
      description: "Rent-it Order deposit payment",
      currency:    'cad'
    )
  end

  def perform_stripe_total_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_total, # in cents
      description: "Rent-it Order deposit payment",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    rental = Rental.new(
      renter_id: current_user.id,
      total_cents: cart_deposit,
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
    cart.each do |tool_id, |
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
end
