class TwitterUser < ActiveRecord::Base
  validates_uniqueness_of :username

  before_create :set_last_checked

  has_many :tweets, foreign_key: 'username', primary_key: 'username'

  def set_last_checked
    self.last_checked = 1.year.ago
  end

  def random_tweet
    count = tweets.count
    tweets.offset(Kernel.rand(count)).first
  end

  def update_tweets(oauth_credentials)
    return if self.last_checked > 5.minutes.ago

    client = Twitter::Client.new(oauth_credentials)
    tweets = client.user_timeline(username)

    tweets.select { |t| t.created_at > last_checked }.each do |tweet_data|
      tweet = Tweet.where(username: username, unique_id: tweet_data.id).first_or_initialize
      tweet.html = client.oembed(
                     tweet_data.id,
                     omit_script: true,
                     hide_media: true,
                     hide_thread: true
                   ).html
      tweet.text = tweet_data.text
      tweet.unique_id = tweet_data.id
      tweet.tweeted_at = tweet_data.created_at
      tweet.save!
    end

    update_attribute :last_checked, Time.now
  end
end
