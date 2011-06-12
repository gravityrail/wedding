class AddExtraFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :region, :string
    add_column :users, :country, :string
    add_column :users, :lat, :float
    add_column :users, :lon, :float
  end

  def self.down
    remove_column :users, :region
    remove_column :users, :country
    remove_column :users, :lat
    remove_column :users, :lon
  end
end
