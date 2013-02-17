class Tweet < ActiveRecord::Base
  attr_accessible :html, :text, :user_id
  belongs_to :user
end
