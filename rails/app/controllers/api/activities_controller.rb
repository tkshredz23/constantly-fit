class Api::ActivitiesController < ApplicationController
  respond_to :json

  def workouts
    opts = activity_params.merge(method: 'type')

    activities = ActivityDecorator.new(Activity.all, opts)
    respond_with activities
  end

  def points
    opts = activity_params.merge(method: 'provider')

    activities = ActivityDecorator.new(Activity.all, opts)
    respond_with activities
  end

  private

    def activity_params
      params.permit(:provider, :type, :period, :order)
    end
end
