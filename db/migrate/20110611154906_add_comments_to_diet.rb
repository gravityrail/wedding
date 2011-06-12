class AddCommentsToDiet < ActiveRecord::Migration
  def self.up
    add_column :users, :diet_comments, :text
  end

  def self.down
    remove_column :users, :diet_comments
  end
end
