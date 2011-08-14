class AddAddressToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :street, :string
    add_column :users, :zip, :string
    add_column :users, :city, :string
  end

  def self.down
    remove_column :users, :street
    remove_column :users, :zip
    remove_column :users, :city
  end
end
