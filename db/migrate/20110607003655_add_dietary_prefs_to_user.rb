class AddDietaryPrefsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :diet, :string, :default => 'none' #vegetarian, vegan, pescetarian
    add_column :users, :allergic_nuts, :boolean, :default => false
    add_column :users, :allergic_wheat, :boolean, :default => false
    add_column :users, :notes, :text
  end

  def self.down
    remove_column :users, :diet
    remove_column :users, :allergic_nuts
    remove_column :users, :allergic_wheat
    remove_column :users, :notes
  end
end
