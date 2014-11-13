class SessionsController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @user = klass.new
  end

  def create
    if auth_hash
      if current_user.accounts.create_from_omniauth(auth_hash, klass)
        redirect_to :root
      else
        render "new"
      end
    else
      #TODO: will revisit this
      render "new"
    end
  end

  def failure
  end

  private

  def auth_hash
    if params[:provider] == :nike
      auth_token = klass.get_token(user_params)
      user_params.merge!(auth_token: auth_token) if auth_token
    else
      request.env['omniauth.auth']
    end
  end

  def klass
    if params[:provider]
      "#{params[:provider].to_s.capitalize}::Account".constantize
    else
      Account
    end
  end

  def set_user
    @user ||= klass.new
  end

  def user_params
    params.require("#{params[:provider]}_account".to_sym)
          .permit(:uid, :password)
          .merge!(provider: params[:provider])
  end
end
