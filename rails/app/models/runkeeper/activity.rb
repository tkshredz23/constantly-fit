module Runkeeper::Activity
  def fetch_recent_activities
    raw_activities = data.fitness_activities.items

    raw_activities.map do |hash|
      fields = field_mapping(hash)
      activities.build_from_hash(fields)
    end
  end

  private

  def field_mapping(data)
    {
      uid: data['uri'].split('/').last,
      name: data['name'],
      type: data['type'],
      distance: data['total_distance'].meters.to.miles.value,
      duration: data['duration'],
      start_date: Date.parse(data['start_time']),
      avg_speed: data['average_speed'],
      steps: 0,
      points: 0,
      calories: 0
    }
  end
end
