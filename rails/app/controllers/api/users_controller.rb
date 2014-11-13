class Api::UsersController < ApplicationController
  respond_to :json

  def show
    user = UserDecorator.decorate(User.find(params[:id]), user_params)

    respond_with user
  end

  def index
    users =  UserDecorator.decorate_collection(User.all)

    respond_with users
  end

  private

  def user_params
    params.permit(:provider, :type, :period, :order)
  end
end
