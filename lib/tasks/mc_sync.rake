API_KEY = 'd38505dc6ab60151f260a7085456e0a5-us2'
LIST_ID = '9194888d32'

namespace :wedding do
  desc "synchonize list with mailchimp"
  task :sync => :environment do
    gb = Gibbon::API.new(API_KEY)

    list_result = gb.list_members({:id => LIST_ID, :limit => 1000}) 

    puts "list_result: #{list_result.inspect}"

    members = list_result['data']

    puts "Number of members: #{members.count}"

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
       u.update_attributes({
        :greeting => merges['GREETING'],
        :first_name => merges['FNAME'],
        :last_name => merges['LNAME'],
        :country => geo['cc'],
        :region => geo['region'],
        :lat => geo['latitude'],
        :lon => geo['longitude']
       })       
       u.save!
      end
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

  desc "update mailchimp merge tags"
  task :update_mc => :environment do
    gb = Gibbon::API.new(API_KEY)

    User.order('email asc').each do |guest|
      melb_rsvp = Rsvp.joins(:guests, :event).where('events.id' => 2, 'users.id' => guest.id).first
      melb_attending = 'unknown'
      if(melb_rsvp.nil?)
        puts "Error! No RSVP for #{guest.email}"
      else
        melb_attending = melb_rsvp.attending
        puts "#{guest.email} has melbourne RSVP: #{melb_rsvp.attending}"
      end

      tahoe_rsvp = Rsvp.joins(:guests, :event).where('events.id' => 1, 'users.id' => guest.id).first
      tahoe_attending = 'unknown'
      if(tahoe_rsvp.nil?)
        puts "Error! No RSVP for #{guest.email}"
      else
        tahoe_attending = tahoe_rsvp.attending
        puts "#{guest.email} has tahoe RSVP: #{tahoe_rsvp.attending}"
      end
      
      merge_vars = {'TAHOE_RSVP' => tahoe_attending, 'MELB_RSVP' => melb_attending}
      result = gb.list_update_member({:id => LIST_ID, :email_address => guest.email, :merge_vars => merge_vars})
      puts "update success: #{result}"
    end


    # u = User.find_by_email('goldsounds@gmail.com')

    # 
    # 
    # puts "done: #{result.inspect}"
  end
end
