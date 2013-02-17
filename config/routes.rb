Tweetbeetz::Application.routes.draw do
  devise_for :users

  match '/users/auth/twitter/callback' => 'callback#create', as: :auth

  get '/:username' => 'tweets#show_for_user', as: 'show_for_user'
  get '/:username/:tweet_id' => 'tweets#show_tweet_for_user', as: 'show_tweet_for_user'

  root :to => 'tweets#index'
  post '/sounds' => 'tweets#sounds'
end
