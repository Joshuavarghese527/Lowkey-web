class ReviewsController < ApplicationController 
def create
    @review = Review.create(review_params)
    location = @review.location

    redirect_to location
  end

  def destroy
    @review = Review.find(params[:id])
    location = @review.location
    @review.destroy

    redirect_to location
  end

  private
    def review_params
      params.require(:review).permit(:star, :comment, :location_id, :user_id)
    end
end