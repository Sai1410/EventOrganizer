Rails.application.routes.draw do

  devise_for :users
  resources :events
  resources :tickets
  devise_scope :user do
    get "/users/get_money" =>'devise/sessions#get_money'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
