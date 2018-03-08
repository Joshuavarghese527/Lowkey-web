class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:approve, :decline]

  def create
    location = Location.find(params[:location_id])

    if current_user.stripe_id.blank?
      flash[:alert] = "Please update your payment method."
      return redirect_to payment_method_path
    else

    start_time = Time.parse(reservation_params[:start_time])
    end_time = Time.parse(reservation_params[:end_time])
    times = (end_time.hour - start_time.hour).to_i

    @reservation = current_user.reservations.build(reservation_params)
    @reservation.location = location
    @reservation.price = location.price
    @reservation.total = location.price * times
    # @reservation.save

    if @reservation.Waiting!
        if location.Request?
          flash[:notice] = "Request sent successfully!"
        elsif @reservation.Approved!
          charge(location, @reservation)
        end
      else
        flash[:alert] = "Cannot make a reservation!"
      end

    end
    redirect_to location
  end

  def your_trips
    @trips = current_user.reservations.order(id: :desc)
  end

  def approve
    charge(@reservation.location, @reservation)
    redirect_to your_reservations_path 
  end

  def decline
    @reservation.Declined!
    redirect_to your_reservations_path
  end

  private

 def charge(location, reservation)
      if !reservation.user.stripe_id.blank?
        customer = Stripe::Customer.retrieve(reservation.user.stripe_id)
        charge = Stripe::Charge.create(
          :customer => customer.id,
          :amount => reservation.total * 100,
          :description => location.lisiting_name,
          :currency => "usd",
        )

        if charge
          reservation.Approved!
          flash[:notice] = "Reservation created successfully!"
        else
          reservation.Declined!
          flash[:alert] = "Cannot charge with this payment method!"
        end
      end
    rescue Stripe::CardError => e
      reservation.Declined!
      flash[:alert] = e.message
    end

   def send_sms(location, reservation)
      @client = Twilio::REST::Client.new
      @client.messages.create(
        from: '+61437798403',
        to: self.phone_number,
        body: "Hi #{reservation.user.fullname}! you have been approved with a booking reservation from '#{start_time} to '#{end_time} at '#{location.listing_name}'"
      )
    end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

    def reservation_params
      params.require(:reservation).permit(:start_time, :end_time)
    end
end