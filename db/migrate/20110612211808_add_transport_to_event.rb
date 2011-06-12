class AddTransportToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :transport, :text
  end

  def self.down
    remove_column :events, :transport
  end
end
