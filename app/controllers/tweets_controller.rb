class TweetsController < ApplicationController
  def index
    if current_user
      # current_user.get_latest_tweets
      @tweets = current_user.tweets[0..4]
    else
      render "connect"
    end
  end
end
