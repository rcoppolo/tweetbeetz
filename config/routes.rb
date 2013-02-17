Tweetbeetz::Application.routes.draw do

  devise_scope :user do
    delete "/logout" => "devise/sessions#destroy", as: :logout
  end

  match '/users/auth/twitter/callback' => 'callback#create', as: :auth

  resources :beats
  root :to => 'beats#index'


end
