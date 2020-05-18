class ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :destroy, :update, :all, :create]
  before_action :set_listing, only: [:show, :edit, :update, :destroy]


  def index
    @listings = Listing.all.sort_by(&:created_at).reverse
  end

  def show
    @listing = Listing.find(params[:id])
    @randomItems = get_random_listings

    if signed_in?
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
    end
  end

  def all
    if current_user.admin
      @listings = Listing.all.sort_by(&:created_at).reverse
      @users = User.all
    else
      @listings = current_user.listings.all
    end
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.create(listing_params)
    if @listing.errors.any?
      render "new"
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
end