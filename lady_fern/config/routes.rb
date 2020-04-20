Rails.application.routes.draw do
  get 'transactions/new'
  get 'transactions/paypal'
  get 'transactions/cash'
  get 'transactions/card'
  get 'users/create'
  get 'users/show'
  get 'users/update'
  get 'users/delete'
  get 'items/create'
  get 'items/show'
  get 'items/update'
  get 'items/delete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
