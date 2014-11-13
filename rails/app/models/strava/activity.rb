module Strava::Activity
  def fetch_recent_activities
    start_date = (Time.now.at_beginning_of_week.to_i - 1.month).to_i

    #raw_activities = data.list_athlete_activities
    raw_activities = data.list_athlete_activities(before: Time.now.to_i, per_page: 200)

    raw_activities.map do |hash|
      fields = field_mapping(hash)
      activities.build_from_hash(fields)
    end
  end

  private

  def field_mapping(data)
    {
      uid: data['id'].to_s,
      name: data['name'],
      type: data['type'],
      distance: data['distance'].meters.to.miles.value,
      duration: data['moving_time'],
      start_date: Date.parse(data['start_date']),
      avg_speed: 0,
      steps: 0,
      points: 0,
      calories: 0
    }
  end
end
