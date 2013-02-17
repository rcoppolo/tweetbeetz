Tweetbeetz::Application.routes.draw do
  devise_for :users

  root :to => 'tweets#index'
  post '/sounds' => 'tweets#sounds'

  match '/users/auth/twitter/callback' => 'callback#create', as: :auth


end
