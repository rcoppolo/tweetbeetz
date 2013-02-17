class TweetsController < ApplicationController

  respond_to :json, only: :sounds

  def index
    if current_user
      current_user.get_latest_tweets
      @tweets = current_user.tweets[0..4]
    else
      render "connect"
    end
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

end
