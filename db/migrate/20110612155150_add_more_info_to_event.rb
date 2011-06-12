class AddMoreInfoToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :accommodation, :text
    add_column :events, :presents, :text
  end

  def self.down
    remove_column :events, :accommodation
    remove_column :events, :presents
  end
end
