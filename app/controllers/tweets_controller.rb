class TweetsController < ApplicationController

  respond_to :json, only: :sounds

  def index
    if current_user
      if current_user.tweets.none? ||
         current_user.tweets.first.created_at < 30.minutes.ago # fixme
        current_user.get_latest_tweets
      end
      @tweets = current_user.tweets(true)[0..4]
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
