class FavouritesController < ApplicationController
  before_action :authenticate_user!

  # Logic for toggling items between favourited and not favourited.
  def toggle_favourite
    listing_id = params[:listing_id]
    if !current_user.favourites.distinct.pluck(:listing_id).include?(listing_id.to_i)
      @favourite = current_user.favourites.create(favourite_params)
      redirect_back(fallback_location: root_path)
    else
      @favouite = current_user.favourites.where(listing_id: listing_id).destroy_all
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def favourite_params
    params.permit(:listing_id)
  end
end