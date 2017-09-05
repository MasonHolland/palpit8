Rails.application.routes.draw do
  root "home#index"
  get "/auth/:provider/callback", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/dashboard", to: "dashboard#show"

  resources :home
  get "/refresh_part", to: "home#refresh_part"


  resources :messages
  resources :chatrooms, param: :slug
  resources :games, param: :slug,  only: [:index, :show]

  mount ActionCable.server => '/cable'

end
