class StringsToTexts < ActiveRecord::Migration
  def up
    remove_column :tweets, :text
    remove_column :tweets, :html
    remove_column :tweets, :urls
    add_column :tweets, :text, :text
    add_column :tweets, :html, :text
    add_column :tweets, :urls, :text
  end

  def down
    remove_column :tweets, :text
    remove_column :tweets, :html
    remove_column :tweets, :urls
    add_column :tweets, :text, :string
    add_column :tweets, :html, :string
    add_column :tweets, :urls, :string
  end
end
