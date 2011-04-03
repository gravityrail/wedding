class ChangeTableDomains < ActiveRecord::Migration
  def self.up
    change_table :domains do |t|
      t.remove :uses_hsts, :uses_https, :mixed_content, :all_https, :all_identifying, :secure_cookies, :ssl_valid
      t.integer :uses_hsts
      t.integer :uses_https
      t.integer :mixed_content
      t.integer :all_https
      t.integer :all_identifying
      t.integer :secure_cookies
      t.integer :ssl_valid
    end
  end

  def self.down
    change_table :domains do |t|
      t.remove :uses_hsts, :uses_https, :mixed_content, :all_https, :all_identifying, :secure_cookies, :ssl_valid
      t.boolean :uses_hsts
      t.boolean :uses_https
      t.boolean :mixed_content
      t.boolean :all_https
      t.boolean :all_identifying
      t.boolean :secure_cookies
      t.boolean :ssl_valid
    end
  end
end
