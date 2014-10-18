class UsersController < ApplicationController
  def index
    # binding.pry
    @users = User.all
  end

  def test
    
  end
end
