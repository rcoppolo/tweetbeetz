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
      urls_with_volumes = TweetToSounds.sounds_for_tweet_with_volumes(tweet.text)

      tweet.urls = urls_with_volumes.flatten.join(" ")
    end
    if tweet.save
      urls_and_volumes = []
      tweet.urls.split(" ").each_slice(2) { |tuple| urls_and_volumes << tuple }
      render json: urls_and_volumes
    end
  end

end
