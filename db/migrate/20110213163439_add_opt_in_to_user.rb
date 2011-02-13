class AddOptInToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :opt_in, :boolean, :null=>false, :default=>true
  end

  def self.down
    remove_column :users, :opt_in
  end
end
