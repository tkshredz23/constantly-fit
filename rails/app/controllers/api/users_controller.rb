class Api::UsersController < ApplicationController
  respond_to :json

  def show
    respond_with(User.find(params[:id]))
  end

  def index
    respond_with({ users: User.all })
  end

  private

  def user_params
    params.permit(:provider, :type, :period, :order)
  end
end
