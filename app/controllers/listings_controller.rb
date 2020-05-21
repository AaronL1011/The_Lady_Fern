class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :destroy, :update, :all, :create]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]

  # Return a listing array sorted by newest.
  def index
    @listings = Listing.all.sort_by(&:created_at).reverse
  end

  # Returning required objects and Stripe API logic for "Buy Now" purchases.
  def show
    @listing = Listing.find(params[:id])
    @randomItems = get_random_listings
  end

  def buy_now
    set_listing
    if signed_in? && @listing.user != current_user
      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: current_user.email,
        line_items: [{
          name: "#{@listing.size} #{@listing.title}",
          description: @listing.description,
          amount: @listing.price.to_i * 100,
          currency: 'aud',
          quantity: 1,
        }],
        payment_intent_data: {
          metadata: {
            user_id: current_user.id,
            listing_id: @listing.id
          }
        },
        success_url: "#{root_url}payments/success?userId=#{current_user.id}&listingId=#{@listing.id}",
        cancel_url: "#{root_url}listings/#{@listing.id}"
      )
      @session_id = session.id
    elsif !signed_in?
      redirect_back(fallback_location: root_path)
      flash.alert = "You need to sign in!"
    else
      redirect_back(fallback_location: root_path)
      flash.alert = "You cannot purchase your own listings!"
    end
  end

  # Logic for returning appropriate dashboard information to users and/or admin.
  def all
    if current_user.admin
      @listings = Listing.all.sort_by(&:created_at).reverse
      @users = User.all
    else
      @listings = current_user.listings.all
    end
    @favourites = current_user.favourites.all
  end

  # Defining a new listing.
  def new
    @listing = Listing.new
  end

  # Creating a new listing.
  def create
    @listing = current_user.listings.create(listing_params)
    if @listing.errors.any?
      render "new"
    else
      redirect_to root_path
    end
  end

  # Returning the edit.html.erb
  def edit
  end

  def search
  end

  # Updating a listing if there are no errors.
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

  # Can you guess?
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
end