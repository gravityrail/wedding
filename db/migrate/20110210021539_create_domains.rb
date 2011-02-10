class CreateDomains < ActiveRecord::Migration
  def self.up
    create_table :domains do |t|
      t.string :name
      t.boolean :uses_hsts
      t.boolean :uses_https
      t.boolean :mixed_content
      t.boolean :all_https
      t.boolean :all_identifying
      t.boolean :secure_cookies
      t.boolean :ssl_valid
      t.string :key_strength
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :domains
  end
end
