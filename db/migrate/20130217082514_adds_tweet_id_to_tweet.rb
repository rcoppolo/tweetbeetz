class AddsTweetIdToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :unique_id, :integer
  end
end
