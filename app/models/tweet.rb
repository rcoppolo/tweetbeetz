class Tweet < ActiveRecord::Base
  attr_accessible :html, :text, :user_id, :urls
  belongs_to :user
end
