class RatingsController < ApplicationController

  def new
  end

  def create
    @track = Track.find(params[:track_id])
    @rating = current_user.attending(@track).create_rating(score: params[:score])
    
    current_user.save

    render 'update'
  end

  def update
    @rating = Rating.find(params[:id])
    @track = @rating.attending.track
    if @rating.update_attributes(score: params[:score])
      respond_to do |format|
        format.js
      end
    end
  end

end

