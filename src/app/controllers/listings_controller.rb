class ListingsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :destroy, :update]
    before_action :set_listing, only: [:show, :edit, :update, :destroy]


    def index
        @listings = Listing.all
    end

    def show
        @listing = Listing.find(params[:id])
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
            redirect_to root_path
        end
    end

    def edit

    end

    def search
    end
    
    def update
        @listing = Listing.update(params["id"], listing_params)
        if @listing.errors.any?
            set_breeds_and_sexes
            render "edit"
        else 
            redirect_to @listing
        end
    end

    def destroy
        Listing.find(params[:id]).destroy
        redirect_to root_path
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