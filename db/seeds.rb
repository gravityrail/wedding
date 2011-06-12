# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts "Seeding Database for Rails env: #{Rails.env}"

puts "Creating Admins"
unless(User.where(:email => 'goldsounds@gmail.com').exists?)
User.create!([
  {:first_name => "Dan", 
   :last_name => 'Walmsley',
   :email => "goldsounds@gmail.com", 
   :password => "#1muppet", 
   :password_confirmation => "#1muppet",
   :role => "admin"}
])
end
unless(User.where(:email => 'kelleashay@gmail.com').exists?)
User.create!([
  {:first_name => "Kellea", 
   :last_name => 'Miller',
   :email => "kelleashay@gmail.com", 
   :password => "password", 
   :password_confirmation => "password",
   :role => "admin"}
])
end

puts "creating events"
if(!Event.where(:title => 'Tahoe, September 2011').exists?)
  Event.create!({
    :title => 'Tahoe, September 2011',
    :start_date => DateTime.civil(2011, 9, 3),
    :end_date => DateTime.civil(2011, 9, 4),
    :description => 'Description of event'
  })
end
if(!Event.where(:title => 'Melbourne, January 2012').exists?)
  Event.create!({
    :title => 'Melbourne, January 2012',
    :start_date => DateTime.civil(2012, 1, 7),
    :end_date => DateTime.civil(2012, 1, 8),
    :description => 'Description of event'
  })
end

#tahoe_event = Event.find_by_title('Tahoe, September 2011')
#
#User.all.each do |user|
#  if(!Rsvp.where(:event_id => tahoe_event.id).exists?) #XXX TODO fix to filter for rsvp's containing specific user
#    puts "creating RSVP for #{user.name} to event #{tahoe_event.title}"
#    Rsvp.create!({
#      :event => tahoe_event,
#      :guests => [user]
#    })
#  end
#end

#melbourne_event = Event.find_by_title('Melbourne, January 2012')
