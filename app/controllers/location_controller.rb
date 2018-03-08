class LocationController < ApplicationController
  def index
    @locations = Location.all
  end

  def show
     @location = Location.find(params[:id])

     @review = Review.new
     @reviews = @location.reviews
     @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end
# ------- Reservation ---------
  def preload
    today = Time.now
    reservations = @location.reservations.where("start_time >= ? OR end_time >= ?", today, today)

    render json: reservations
  end
   def preview
    start_time = Time.parse(params[:start_date])
    end_time = Time.parse(params[:end_date])
  end

  def photo_upload
    @photos = @location.photos
  end

  def search
    # STEP 1
    if params[:search].present? && params[:search].strip != ""
      session[:loc_search] = params[:search]
    end

    # STEP 2
    if session[:loc_search] && session[:loc_search] != ""
      @locations_address = Location.where(active: true).near(session[:loc_search], 20, order: 'distance')
    else
      @locations_address = Location.where(active: true).all
    end

    # STEP 3
    @search = @locations_address.ransack(params[:q])
    @locations = @search.result

    @arrlocations = @locations.to_a

  end
end
