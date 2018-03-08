class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  def show
    @user = User.find(params[:id])
  end

 def update_phone_number
    current_user.update_attributes(user_params)
    current_user.generate_pin
    current_user.send_pin

    redirect_to edit_user_registration_path, notice: "Saved..."
  rescue Exception => e
    redirect_to edit_user_registration_path, alert: "#{e.message}"
  end

  def verify_phone_number
    current_user.verify_pin(params[:user][:pin])

    if current_user.phone_verified
      flash[:notice] = "Your phone number is verified."
    else
      flash[:alert] = "Cannot verify your phone number."
    end

    redirect_to edit_user_registration_path

  rescue Exception => e
    redirect_to edit_user_registration_path, alert: "#{e.message}"
  end

  def payment
  end

  def add_card
    if current_user.stripe_id.blank?
      customer = Stripe::Customer.create(
        email: current_user.email
        )
      current_user.stripe_id = customer.id
      current_user.save
    else
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
    end


    #Add Credit Card to Stripe
    month, year = params[:expiry].split(/ \/ /)
    new_token = Stripe::Token.create(:card => {
       :number => params[:number],
       :exp_month => month,
       :exp_year => year,
       :cvc => params[:cvv]
      })
    customer.sources.create(source: new_token.id)

    flash[:notice] = "Your card is saved."
    redirect_to payment_method_path
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to payment_method_path
  end

  private

    def user_params
      params.require(:user).permit(:phone_number, :pin)
    end
end