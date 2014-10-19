class UsersController < ApplicationController
  def index

    # binding.pry
    @users = User.all

  end

  def show
  end

  def edit

  end
end
