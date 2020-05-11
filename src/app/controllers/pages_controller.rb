class PagesController < ApplicationController
    def contact
    end

    def search
        search_query = params[:search].downcase
        @listings = get_search_listings(search_query)
    end

    def profile

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
end

