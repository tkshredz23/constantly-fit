module Jawbone::Activity
  def fetch_recent_activities
    raw_activities = data.workouts

    raw_activities =
      begin
        data.workouts
      rescue RuntimeError
        data.workouts if reset_token!
      end

    return unless raw_activities['data']['items']

    raw_activities['data']['items'].map do |hash|
      fields = field_mapping(hash)
      activities.build_from_hash(fields)
    end
  end

  private

  def field_mapping(data)
    {
      uid: data['xid'],
      name: data['title'],
      type: data['workout'],
      distance: data['details']['meters'].meters.to.miles.value,
      duration: data['details']['time'],
      start_date: Date.parse(data['date']),
      avg_speed: 0,
      steps: data['details']['steps'],
      points: 0,
      calories: data['details']['calories']
    }
  end
end
