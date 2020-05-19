module ListingHelper
    def favourited(listing)
        return current_user.favourites.distinct.pluck(:listing_id).include?(listing.id)
    end
end
