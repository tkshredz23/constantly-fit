class ActivitiesController < ApplicationController
  def points
    opts = activity_params.merge(method: 'provider')
    activities = ActivityDecorator.new(Activity.all, opts).to_json

    @response = JSON.parse(activities)
  end

  def workouts
    opts = activity_params.merge(method: 'type')
    activities = ActivityDecorator.new(Activity.all, opts).to_json

    @response = JSON.parse(activities)
  end

  def users

  end

  private

    def activity_params
      params.permit(:provider, :type, :period, :order)
    end
end
