class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :twitter_sign_up
  has_many :tweets

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  def get_latest_tweets
    client = Twitter::Client.new(oauth_token: oauth_token,
                                 oauth_token_secret: oauth_token_secret)
    client.user_timeline(username)[0..4].each do |tweet|
      Tweet.create(html: client.oembed(tweet.id, omit_script: true).html,
                   text: tweet.text,
                   user_id: id)
    end
  end

  def self.from_omniauth(auth)
    where(auth.slice(:uid)).first_or_create do |user|
      user.email = "#{SecureRandom.hex(10)}@example.com"
      user.password = SecureRandom.hex(10)
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.oauth_token = auth.credentials.token
      user.oauth_token_secret = auth.credentials.secret
    end
  end

end
