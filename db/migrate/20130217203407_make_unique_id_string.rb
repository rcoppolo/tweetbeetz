class MakeUniqueIdString < ActiveRecord::Migration
  def up
    remove_column :tweets, :unique_id
    add_column :tweets, :unique_id, :string
    add_index :tweets, :unique_id
  end

  def down
    remove_column :tweets, :unique_id
    add_column :tweets, :unique_id, :integer
  end
end
