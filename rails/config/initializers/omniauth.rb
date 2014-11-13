Rails.application.config.middleware.use OmniAuth::Builder do
    provider :fitbit, ENV['FITBIT_KEY'], ENV['FITBIT_SECRET']
    provider :runkeeper, ENV['RUNKEEPER_KEY'], ENV['RUNKEEPER_SECRET']
    provider :strava, ENV['STRAVA_KEY'], ENV['STRAVA_SECRET'], scope: 'public'
    provider :jawbone, ENV['JAWBONE_KEY'], ENV['JAWBONE_SECRET']
end
