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

    def all
        if current_user.admin
            @listings = Listing.all
        end
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
            set_listing
            render "edit"
        else
            if @listing.in_stock
                redirect_to @listing
            else
                redirect_to root_path
            end
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

    def listing_params
        params.require(:listing).permit(:title, :description, :user_id, :size, :price, :in_stock, :picture)
    end

    def get_faux_listings
        faux_listings = []
        object = { id: 8, listing_id: 17, user_id: 1, title: nil, description: nil, price: nil, in_stock: nil, created_at: "2020-05-15 10:18:14", updated_at: "2020-05-15 10:18:14", size: nil}
        for i in 0..2
            p faux_listings.push(object)
        end
        return faux_listings
    end
end