class TweetsController < ApplicationController
  respond_to :json, only: :sounds
  before_filter :must_be_logged_in

  def index
    redirect_to show_for_user_url(current_user.username)
  end

  def show_for_user
    twitter_user = TwitterUser.find_or_create_by_username(params[:username])
    twitter_user.update_tweets(twitter_credentials)

    tweet = nil

    loop do
      tweet = twitter_user.random_tweet

      if tweet.urls.nil?
        urls = TweetToSounds.sounds_for_tweet(tweet.text)
        tweet.urls = urls.join(" ")
        tweet.save
      end

      break unless tweet.urls == ""
    end

    redirect_to show_tweet_for_user_url(twitter_user.username, tweet.unique_id)
  end

  def show_tweet_for_user
    @tweet = Tweet.find_by_unique_id(params[:tweet_id])
  end

  def sounds
    tweet = Tweet.find(params[:id])
    if tweet.urls.nil?
      urls = TweetToSounds.sounds_for_tweet(tweet.text)
      tweet.urls = urls.join(" ")
    end
    if tweet.save
      render json: tweet.urls.split(" ")
    end
  end

  protected

  def must_be_logged_in
    if !current_user
      render "connect"
    end
  end

  def twitter_credentials
    {
      oauth_token: current_user.oauth_token,
      oauth_token_secret: current_user.oauth_token_secret
    }
  end
end
