class AddFieldsToUserAgain < ActiveRecord::Migration
  def self.up
    add_column :users, :greeting, :string
    add_column :users, :dance_song, :string
    add_column :users, :romantic_song, :string
  end

  def self.down
    remove_column :users, :greeting
    remove_column :users, :dance_song
    remove_column :users, :romantic_song
  end
end
