class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.text :description
      t.text :location
      t.float :lat
      t.float :lon
      t.string :mapurl

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
