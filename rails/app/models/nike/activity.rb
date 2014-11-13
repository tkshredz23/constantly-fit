module Nike::Activity
  def fetch_recent_activities
    opts = {
      start_date: Time.now.at_beginning_of_year.strftime('%Y-%m-%d'),
      end_date: Time.now.strftime('%Y-%m-%d'),
      count: 1000
    }

    raw_activities =
      begin
        data.activities(opts)
      rescue RuntimeError => ex
        data.activities(opts) if reset_token!
      end

    raw_activities.map do |hash|
      fields = field_mapping(hash)
      activities.build_from_hash(fields)
    end
  end

  private

  def field_mapping(data)
    {
      uid: data.activity_id,
      name: data.activity_id,
      type: data.activity_type,
      distance: data.metric_summary['distance'].to_f.kilometers.to.miles.value,
      duration: data.metric_summary['duration'],
      start_date: data.start_time,
      steps: data.metric_summary['steps'],
      points: data.metric_summary['fuel'],
      calories: data.metric_summary['calories']
    }
  end

end
