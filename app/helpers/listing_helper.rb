module ListingHelper

  # Helper to return boolean value if user has an item favourited.
  def favourited(listing)
    return current_user.favourites.distinct.pluck(:listing_id).include?(listing.id)
  end

end
