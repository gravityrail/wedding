class AddShortNameToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :short_name, :string
  end

  def self.down
    remove_column :events, :short_name
  end
end
