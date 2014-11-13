namespace :cron do
  desc "Job to fetch activities for strava users "
  task update_activities: :environment do
    # Get all strava users
    #
    # For each user
    # # Authenticate
    # # Deal with auth issue
    # # Update user or profile is necessary
    # # Get latest activities

    Account.all.each do |account|
      account.fetch_recent_activities
    end
  end
end
