class UserDecorator < Draper::Decorator
  delegate_all

  def initialize(user, details = true)
    @show_details = details

    super(user)
  end

  def avatar_url
    # default_url = "#{h.root_path}/assets/guest.png"
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase

    # "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
    # "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
    "http://gravatar.com/avatar/#{gravatar_id}.png"
  end

  def activity_by_provider
    ActivityDecorator.new(activities, {method: 'provider'}, false)
  end

  def activity_by_type
    ActivityDecorator.new(activities, {method: 'type'}, false)
  end

  def activities_json
    activities.aggregated_activities_by_provider.map do |value|
      {
        provider: value.account.type.deconstantize.downcase,
        calories: value.calories,
        distance: (value.distance).round(2),
        duration: value.duration,
        points: value.points,
        steps: value.steps,
        # avg_speed: value.avg_speed,
        count: value.count
      }
    end
  end

  def as_json(*)
    hash = {
      id: SecureRandom.uuid,
      email: email,
      avatar: avatar_url,
      first_name: first_name,
      last_name: last_name,
    }

    if @show_details
      hash[:workouts] = activity_by_type
      hash[:points] = activity_by_provider
    end

    hash
  end

end
