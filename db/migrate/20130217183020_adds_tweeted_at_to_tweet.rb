class AddsTweetedAtToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :tweeted_at, :time
  end
end
