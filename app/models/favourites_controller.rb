class FavouritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @favourite = Favourite.create(favourite_params)
  end

  private

  def favourite_params
    params.require(:favourite).permit(:user_id, :listing_id)
  end
end