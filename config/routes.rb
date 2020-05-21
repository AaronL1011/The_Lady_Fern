Rails.application.routes.draw do
  # User account routes.
  devise_for :users
  get "/pages/profile", to: "pages#profile", as: "profile"
  root 'listings#index'

  # Dashboard listings view.
  get "/listings/all", to: "listings#all", as: "admin_listing"

  # Miscellanious routes.
  get "/pages/contact", to: "pages#contact", as: "contact"
  get "/pages/search", to: "pages#search", as: "search"

  # Cart routes.
  get "/cart", to: "carts#show", as: "cart"
  post "/cart", to: "carts#add", as: "add_to_cart"
  delete "/cart/:id", to: "carts#remove", as: "remove_from_cart"
  put "/cart/:id", to: "carts#update", as: "update_cart"
  get "/cart/checkout", to: "carts#checkout", as: "checkout"

  # Creating new listings.
  post "/listings", to: "listings#create"
  get "/listings/new", to: "listings#new", as: "new_listing"

  # Deleting listings.
  delete "/listings/:id", to: "listings#destroy"
    
  # Retrieving single listings.
  get "/listings/:id", to: "listings#show", as: "listing"

  # Buy Now listings route.

  post "/listings/buy_now", to: "listings#buy_now", as: "buy_now"
  
  # Stripe payment routes.
  get "/payments/success", to: "payments#success"

  # Editing listings routes.
  get "/listings/:id/edit", to: "listings#edit", as: "edit_listing"
  put "/listings/:id", to: "listings#update"
  patch "/listings/:id", to: "listings#update"

  # Favourites routes.
  post "/favourites", to: "favourites#toggle_favourite", as: "toggle_favourite"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
