class CartsController < ApplicationController
    before_action :authenticate_user!
    
    def show 
        get_user_and_cart
        get_total_price
        @randomItems = get_random_listings
    end

    # Check if current users cart includes specified listing to add, if so, increase quantity by 1, otherwise add new listing to cart.
    def add
        get_user_and_cart
        get_listing
        if @user.carts.distinct.pluck(:listing_id).include?(@listing.id)
            cart_listing = @user.carts.find_by_listing_id(@listing.id)
            listing_qty = cart_listing.qty + 1
            cart_listing.update(qty: listing_qty)
        else
            @user.carts.create("listing_id" => @listing.id, "qty" => 1)
        end
        redirect_to @listing
    end

    def remove
        Cart.find(params[:id]).destroy
        redirect_to cart_path
    end

    # Logic for updating cart listing quantities from cart view.
    def update
        new_quantity = params[:new_quantity]
        cart_listing = Cart.find(params[:id])
        
    end

    def destroy

    end

    private

    def get_user_and_cart
        @user = current_user
        @cart = Cart.where("user_id": @user.id)
    end

    def get_listing
        @listing = Listing.find(params[:id])
    end
    
    def get_total_price
        @total_price = 0
        for item in @cart
            @total_price += item.listing.price * item.qty
        end
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