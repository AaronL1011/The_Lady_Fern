Rails.application.routes.draw do
  devise_for :users
  root 'listings#index'
  
  post "/listings", to: "listings#create"
  get "/listings/new", to: "listings#new", as: "new_listing"
  get "/listings/:id", to: "listings#show", as: "listing"
  put "/listings/:id", to: "listings#update"
  patch "/listings/:id", to: "listings#update"
  delete "/listings/:id", to: "listings#destroy"
  get "/listings/:id/edit", to: "listings#edit", as: "edit_listing"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
