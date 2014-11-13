class Activity < ActiveRecord::Base
  include Conversion

  belongs_to :account

  ACTIVITY_TYPES = %w(walking running swimming biking training climbing other)
  PROVIDERS = %w(nike fitbit jawbone strava runkeeper)
  TIME_FRAMES = %w(day week month year)
  SORT_ORDERS  = %w(distance duration calories points steps)

  ACTIVITY_TYPES.each do |activity|
    scope activity.to_sym, -> { where(kind: activity) }
  end

  PROVIDERS.each do |provider|
    scope provider.to_sym, -> { joins(:account).where("accounts.type = '#{provider.capitalize}::Account'") }
  end

  TIME_FRAMES.each do |period|
    scope period.to_sym, -> { where('start_date >= ?', Date.current.send("at_beginning_of_#{period}".to_sym)) }
  end

  # METRICS_SUM = <<-SQL
  #   sum(distance) distance,
  #   sum(duration) duration,
  #   sum(calories) calories,
  #   sum(points) points,
  #   sum(steps) steps
  # SQL

  METRICS_SUM = "sum(activities.distance) distance, sum(activities.duration) duration, sum(activities.calories) calories, sum(activities.points) points, sum(activities.steps) steps, sum(activities.avg_speed) avg_speed, count(*)"

  def self.activity_types
    ACTIVITY_TYPES
  end

  def self.providers
    PROVIDERS
  end

  def self.time_frames
    TIME_FRAMES
  end

  def self.sort_orders
    SORT_ORDERS
  end

  def self.build_from_hash(opts = {})
    # TODO: go meta
    begin
      where(opts.slice(:uid)).first_or_create do |activity|
        activity.uid =  opts[:uid]
        activity.name =  opts[:name]
        activity.kind =  normalize_type opts[:type]
        activity.distance = opts[:distance].to_f.round(2)
        activity.duration = parse_elapsed_time_to_seconds opts[:duration]
        activity.start_date = parse_date opts[:start_date]
        activity.steps = opts[:steps]
        activity.points = opts[:points]
        activity.calories = opts[:calories]
        activity.avg_speed = speed(activity.distance, activity.duration)
      end
    rescue Exception => ex
      puts ex.inspect
    end
  end

  def self.aggregated_activities_by_kind
    joins(account: :user)
    .group('activities.kind, accounts.user_id')
    .select("accounts.user_id, activities.kind, #{METRICS_SUM}")
  end

  def self.aggregated_activities_by_provider
    joins(account: :user)
    .group('accounts.user_id, activities.account_id, accounts.type')
    .select("accounts.user_id, activities.account_id, #{METRICS_SUM}")
  end

  def self.order_by(opts)
    sort, direction = opts[:order].split(',')

    query = self

    if SORT_ORDERS.include?(sort)
      query = %w(desc asc).include?(direction) ? query.order("#{sort} #{direction}")
                                               : query.order(sort)
    end

    query
  end

  def self.filter_by(opts)
    provider = opts[:provider]
    type = opts[:type]
    period = opts[:period]

    query = self

    query = query.send(provider) if PROVIDERS.include?(provider) && respond_to?(provider)
    query = query.send(type) if ACTIVITY_TYPES.include?(type) && respond_to?(type)
    query = if TIME_FRAMES.include?(period) && respond_to?(period)
              query.send(period)
            else
              query.week
            end
  end
end
