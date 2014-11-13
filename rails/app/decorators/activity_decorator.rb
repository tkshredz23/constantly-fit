class ActivityDecorator < Draper::Decorator
  delegate_all

  def initialize(activities, opts, details = true)
    @show_user = details

    query = activities.filter_by(opts)

    if opts[:method] == "type"
      query = query.aggregated_activities_by_kind
      @method = 'activities_by_type'
    else
      query = query.aggregated_activities_by_provider
      @method = 'activities_by_provider'
    end

    query = query.order_by(opts) if opts[:order]

    @activities = query

    super(@activities)
  end

  def as_json(*)
    send(@method.to_s)
  end

  def activities_by_type
    @activities.group_by(&:kind).map do |group, acts|
      {
        type: group,
        items: activity_list(acts)
      }
    end
  end

  def user_decorator(id)
    user = User.find(id)

    UserDecorator.new(user, false)
  end

  def activities_by_provider
    @activities.group_by{|x| x.account.type }.map do |type, acts|
      {
        provider: type.deconstantize.downcase,
        items: activity_list(acts)
      }
    end
  end

  def activity_list(acts)
    acts.map do |act|
      hash = {}

      hash[:user] = user_decorator(act.user_id) if @show_user
      hash[:duration] = time_str(act.duration)
      hash[:distance] = act.distance
      hash[:points] = act.points
      hash[:calories] = act.calories
      hash[:steps] = act.steps
      hash[:count] = act.count

      hash
    end
  end
end
