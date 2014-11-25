class Api::ActivitiesController < ApplicationController
  respond_to :json

  def workouts
    user = User.find(params[:id])
    respond_with({ workouts: user.activities })
    # opts = activity_params.merge(method: 'type')

    # activities = ActivityDecorator.new(Activity.all, opts)
    # respond_with({ workouts: activities })
  end

  def points
    # opts = activity_params.merge(method: 'provider')

    # activities = ActivityDecorator.new(Activity.all, opts)
    # respond_with({ points: activities })
  end

  private

    def activity_params
      params.permit(:provider, :type, :period, :order)
    end
end
