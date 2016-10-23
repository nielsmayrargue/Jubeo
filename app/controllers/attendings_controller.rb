

class AttendingsController < ApplicationController

  before_action :set_track, only: [:new, :create, :destroy]

  def new
  end

  def create
    if params[:attending]
      if params[:attending][:coupon]

        if @track.verify_coupon(params[:attending][:coupon]) == true

          @attending = current_user.attendings.create(track: @track)
          @rating = nil

          @attending.is_paid = true
          @attending.save

        else

          redirect_to(track_path(@track)) and return

        end
end
    elsif @track.price > 0

          @attending = current_user.attendings.create(track: @track)
          @rating = nil

            # Amount in cents
        @amount = @track.price * 100

        customer = Stripe::Customer.create(
          :email => current_user.email,
          :card  => params[:stripeToken]
        )

        charge = Stripe::Charge.create(
          :customer    => customer.id,
          :amount      => @amount,
          :description => 'Rails Stripe customer',
          :currency    => 'eur'
        )

        @attending.is_paid = true
        @attending.save

    else

      @attending = current_user.attendings.create(track: @track)
      @rating = nil

    end

    respond_to do |format|
      format.html { redirect_to(track_path(@track)) }
      format.js
    end

    rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_track_attending_path(@track)

  end

  def destroy
    @attending = Attending.find(params[:id])
    @attending.destroy

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def index
  end

  private

  def set_track
    @track = Track.find(params[:track_id])
  end

  def attending_params
    params.require(:attending).permit(:track_id, :user_id, :transaction_cost, :is_paid, :track_id)
  end

end
