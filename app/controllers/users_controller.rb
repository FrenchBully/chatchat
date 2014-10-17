class UsersController < ApplicationController
  def index
    # binding.pry
    @users = User.all
  end
end
