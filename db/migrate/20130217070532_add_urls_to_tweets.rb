class AddUrlsToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :urls, :string
  end
end
