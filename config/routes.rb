Tweetbeetz::Application.routes.draw do
  devise_for :users

  resources :beats
  root :to => 'beats#index'

  match '/users/auth/twitter/callback' => 'callback#create', as: :auth

end
