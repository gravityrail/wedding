# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts "Seeding Database for Rails env: #{Rails.env}"

puts "Creating Admin"
User.create([
  {:name => "Administrator", 
   :email => "goldsoudns@gmail.com", 
   :password => "#1muppet", 
   :password_confirmation => "#1muppet",
   :role => "admin"}
])