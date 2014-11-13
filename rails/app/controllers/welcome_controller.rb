class WelcomeController < ApplicationController
  def index
    @users = Account.all

  end
end
