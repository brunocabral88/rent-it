class RentalsController < ApplicationController
  include CartDeposit

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

        redirect_to(rental_path(rental), notice: 'Your Order has been placed.')
      else
        redirect_to(cart_path, error: rental.errors.full_messages.first)
      end

  rescue Stripe::CardError => e
    redirect_to cart_path, error: e.message
  end

  def final_charge_and_refund
      @deposit_rental = Rental.find(params[:rental_id])
      @deposit_rental.update(returned: true)
      # if rental has a deposit charge, proceed to refund
      if @deposit_rental.stripe_charge_id
        charge = perform_stripe_refund(@deposit_rental)
        refund = create_final_charge_and_refund(@deposit_rental, charge)
        redirect_to(rental_path(@deposit_rental), notice: 'Renting process successfully finished')

      else
        redirect_to(cart_path, error: @deposit_rental.errors.full_messages.first)
      end

    rescue Stripe::CardError => e
      redirect_to cart_path, error: e.message
  end


  def perform_stripe_deposit_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_deposit(cart), # in cents
      description: "Rent-it Order deposit payment",
      currency:    'cad'
    )
  end

  def perform_stripe_refund(rental)
    Stripe::Refund.create(
      charge: rental.stripe_charge_id,
      amount: refund_amount(rental)
    )
  end

  private


  def create_order(stripe_charge)
    order_with_amount(stripe_charge, cart_deposit(cart), check_dates: true)
  end

  def create_final_charge_and_refund(rental, stripe_charge)
    order_with_amount(stripe_charge, refund_amount(rental))
  end

  def order_with_amount(stripe_charge, amount, check_dates: false)
    rental = Rental.new(
      renter_id: current_user.id,
      total_cents: amount,
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
    if check_dates && (rental.start_date.blank? || rental.end_date.blank?)
      flash[:notice] = "Please fill the start and end date fields"
    else
      rental.save!

    end
    rental
  end

  # def cart_deposit(tools)
  #   total = 0
  #   tools.each do |tool_id|
  #     if t = Tool.find_by(id: tool_id)
  #       total += t.deposit_cents.to_i
  #     end
  #   end
  #   total
  # end

  def refund_amount(rental)
    total = 0
    rental.tools.each do |tool|
      daily_fee = tool.daily_rate_cents
      renting_duration = (rental.end_date - rental.start_date).to_i
      total += daily_fee * renting_duration
    end
    if cart_deposit(rental.tools) > total
      return cart_deposit(rental.tools) - total
    else
      return 1
    end
  end


end
