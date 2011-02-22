# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts "Seeding Database for Rails env: #{Rails.env}"

puts "Creating Admins"
User.create([
  {:name => "Dan", 
   :email => "goldsounds@gmail.com", 
   :password => "#1muppet", 
   :password_confirmation => "#1muppet",
   :role => "admin"}
])
User.create([
  {:name => "Jochai", 
   :email => "jochai@accessnow.org", 
   :password => "abX954g", 
   :password_confirmation => "abX954g",
   :role => "admin"}
])
User.create([
  {:name => "Brett", 
   :email => "brett@accessnow.org", 
   :password => "678vka", 
   :password_confirmation => "678vka",
   :role => "admin"}
])
