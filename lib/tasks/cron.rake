desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
#  if Time.now.hour % 4 == 0 # run every four hours
    puts "Getting new users from Mailchimp"
    Rake::Task['wedding:sync'].execute
    puts "Creating RSVPs"
    Rake::Task['wedding:create_rsvps'].execute
    puts "Updating MailChimp with RSVPs"
    Rake::Task['wedding:update_mc'].execute
    puts "done."
#  end

#  if Time.now.hour == 0 # run at midnight
#    User.send_reminders
#  end
end

