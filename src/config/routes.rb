Rails.application.routes.draw do
  devise_for :users
  get "/pages/profile", to: "pages#profile", as: "profile"
  root 'listings#index'
  
  # miscellanious routes
  get "/pages/contact", to: "pages#contact", as: "contact"
  get "/pages/search", to: "pages#search", as: "search"

  # cart routes
  get "/cart", to: "carts#show", as: "cart"
  post "/cart", to: "carts#add", as: "add_to_cart"
  delete "/cart/:id", to: "carts#remove", as: "remove_from_cart"

  # creating new listings
  post "/listings", to: "listings#create"
  get "/listings/new", to: "listings#new", as: "new_listing"

  # retrieving single listings
  get "/listings/:id", to: "listings#show", as: "listing"
  # deleting listings
  delete "/listings/:id", to: "listings#destroy"

  # editing listings
  get "/listings/:id/edit", to: "listings#edit", as: "edit_listing"
  put "/listings/:id", to: "listings#update"
  patch "/listings/:id", to: "listings#update"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
