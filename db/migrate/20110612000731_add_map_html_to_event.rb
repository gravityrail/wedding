class AddMapHtmlToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :maphtml, :text
  end

  def self.down
    remove_column :events, :maphtml
  end
end
