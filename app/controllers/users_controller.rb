class UsersController < ApplicationController
  def index

    # binding.pry
    @users = User.all

  end

  def show
  	@user = User.find(params[:id])
  end

  def edit

  end
end
