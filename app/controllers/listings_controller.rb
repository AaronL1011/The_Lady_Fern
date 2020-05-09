class ListingsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :destroy, :update]
    before_action :set_listing, only: [:show, :edit, :update, :destroy]


    def index
        @listings = Listing.all
    end

    def show
        @randomItems = get_random_listings
    end

    def new
        @listing = Listing.new
    end

    def create
        @listing = current_user.listings.create(listing_params)
        if @listing.errors.any?
            # render "new"
        else 
            redirect_to listings_path
        end
    end

    def update
    end

    def destroy
        Listing.find(params[:id]).destroy
        redirect_to listings_path
    end

    private

    def set_listing
        @listing = Listing.find(params[:id])
    end

    def get_random_listings
        listingsArray = []
        i = 0
        while i <= 2
            listing = Listing.all.sample
            if !listingsArray.include?(listing)
                listingsArray.push(listing)
                i += 1
            end
        end
        return listingsArray
    end

    def listing_params
        params.require(:listing).permit(:title, :description, :user_id, :size, :price, :in_stock, :picture)
    end
end