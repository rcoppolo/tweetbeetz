class Tweet < ActiveRecord::Base
  attr_accessible :html, :text, :user_id, :urls, :unique_id, :tweeted_at
  validates_uniqueness_of :unique_id
  belongs_to :user
end
