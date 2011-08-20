class AddAnagramToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :anagram, :string
  end

  def self.down
    remove_column :users, :anagram
  end
end
