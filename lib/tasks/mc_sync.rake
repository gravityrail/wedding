API_KEY = 'd38505dc6ab60151f260a7085456e0a5-us2'
LIST_ID = '9194888d32'

namespace :wedding do
  desc "synchonize list with mailchimp"
  task :sync => :environment do
    gb = Gibbon::API.new(API_KEY)

    list_result = gb.list_members({:id => LIST_ID}) 

#    puts "list_result: #{list_result.inspect}"

    members = list_result['data']

#    @users = gb.list_member_info({:id => SITE['mc_list_id'], :email_address => [email]})
    members.each do |m|
      email = m['email']
      info_result = gb.list_member_info({:id => LIST_ID, :email_address => [email]})
      info = info_result['data'].first
      puts "info: #{info.inspect}\n\n"
      merges = info['merges']
      geo = info['geo']

      puts "geo: #{geo.inspect}\n\n"

      if(!geo.is_a?(Hash))
        geo = {}
      end

      u = User.find_or_initialize_by_email(email)

      if(u.new_record?)
        u.update_attributes({:password => 'ab4321', :password_confirm => 'ab4321'})
      end

      u.update_attributes({
        :greeting => merges['GREETING'],
        :first_name => merges['FNAME'],
        :last_name => merges['LNAME'],
        :country => geo['cc'],
        :region => geo['region'],
        :lat => geo['latitude'],
        :lon => geo['longitude']
      })

      puts "Last name: #{u.last_name}\n\n"

      u.save!
    end
  end

  desc "create rsvp's"
  task :create_rsvps => :environment do
    User.all.each do |user|
      email = user.email
      Event.all.each do |event|
        rsvp = Rsvp.for_email_at_event(email, event)
        if(rsvp)
          puts "Found RSVP: #{rsvp}\n"
        else
          rsvp = Rsvp.new
          rsvp.update_attributes({
            :guests => [user],
            :event => event
          })
          rsvp.save!
        end

      end
    end
  end
end
