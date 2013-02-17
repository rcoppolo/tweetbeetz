class Tweet < ActiveRecord::Base
  attr_accessible :html, :text, :user_name, :urls, :unique_id, :tweeted_at
  validates_uniqueness_of :unique_id
end
