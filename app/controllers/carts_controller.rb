class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user_and_cart, only: [:show, :checkout, :add]

  # return items for view
  def show
    get_total_price
    @randomItems = get_random_listings
  end

  # logic for Stripe API checkout
  def checkout
    get_stripe_line_items
    sleep(1)
    if @cart.count > 0
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: current_user.email,
        line_items: @cart_array,
        payment_intent_data: {
          metadata: {
            user_id: current_user.id,
            listing_id: current_user.carts.first.id
          }
        },
        success_url: "#{root_url}payments/success?userId=#{current_user.id}&listingId=#{current_user.carts.first.id}",
        cancel_url: "#{cart_url}"
      )

      @session_id = session.id
    else
      redirect_back(fallback_location: root_path)
    end
  end

  # Check if current users cart includes specified listing to add, if so, increase quantity by 1, otherwise add new listing to cart.
  def add
    set_listing
    if @listing.user != current_user
      if @user.carts.distinct.pluck(:listing_id).include?(@listing.id)
        cart_listing = @user.carts.find_by_listing_id(@listing.id)
        listing_qty = cart_listing.qty + 1
        cart_listing.update(qty: listing_qty)
        redirect_back(fallback_location: root_path)
      else
        @user.carts.create("listing_id" => @listing.id, "qty" => 1)
        redirect_back(fallback_location: root_path)
      end
    else
      redirect_back(fallback_location: root_path)
      flash.alert = "You cannot purchase your own listings!"
    end
  end

  # Logic for removing item from cart
  def remove
    Cart.find(params[:id]).destroy
    redirect_to cart_path
  end

  # Logic for updating cart listing quantities from cart view.
  def update
    new_quantity = params[:new_quantity]
    cart_listing = Cart.find(params[:id])
  end


  private

  # Get array for Stripe invoice
  def get_stripe_line_items
    @cart_array = []
    for item in @cart
      @cart_array.push({name: "#{item.listing.size} #{item.listing.title}", description: item.listing.description, amount: item.listing.price.to_i * 100, currency: 'aud', quantity: item.qty })
    end
  end


  def get_user_and_cart
    @user = current_user
    @cart = Cart.where("user_id": @user.id)
  end

  def set_listing
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