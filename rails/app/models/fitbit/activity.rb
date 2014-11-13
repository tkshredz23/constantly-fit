module Fitbit::Activity
  def fetch_recent_activities
    begin
      raw_activities = data.recent_activities

      raw_activities.map do |hash|
        fields = field_mapping(hash)
        activities.build_from_hash(fields)
      end
    rescue Exception => ex
      puts ex.inspect
    end
  end

  private

  def field_mapping(data)
    {
      uid: data['uid'].split('/').last,
      name: data['name'],
      type: data['type'],
      distance: data['total_distance'].meters.to.miles.value,
      duration: data['duration'],
      start_date: Date.parse(data['start_date']),
      avg_speed: data['speed'],
      steps: 0,
      points: 0,
      calories: 0
    }
  end
end
