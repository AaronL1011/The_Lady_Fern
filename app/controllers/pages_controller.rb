class PagesController < ApplicationController
  def contact
  end

  def search
    search_query = params[:search].downcase
    @listings = get_search_listings(search_query)
    @randomItems = get_random_listings
  end

  def profile
    @user = current_user
    @favourites = current_user.favourites.all
  end

  private

  def get_search_listings(query)
    query_listings = []
    all_listings = Listing.all
    for listing in all_listings
      if listing.title.downcase.include?(query)
        query_listings.push(listing)
      elsif listing.size.downcase.include?(query)
        query_listings.push(listing)
      end
    end
    return query_listings
  end

  # 3 random listings for recommending to users
  def get_random_listings
    listingsArray = []
    i = 0
    listing_count = Listing.where("in_stock": true).count
    if listing_count >= 4
      while i <= 2
        random_listing = Listing.all.sample
        if !listingsArray.include?(random_listing) && random_listing != @listing && random_listing.in_stock
          listingsArray.push(random_listing)
          i += 1
        end
      end
      return listingsArray
    else
      return nil
    end
  end
end

