class RearrangeSchema < ActiveRecord::Migration
  def up
    add_column :tweets, :username, :string
    remove_column :tweets, :user_id

    create_table :twitter_users do |t|
      t.string :username
      t.datetime :last_checked
      t.timestamps
    end
  end

  def down
    drop_table :twitter_users

    add_column :tweets, :user_id, :integer
    remove_column :tweets, :username
  end
end
