class UsersController < ApplicationController
  before_filter :authenticate_user!


  def index
    @users = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	# @user = User.find(params[:id])
  	# if @user.update(params.require(:user).permit(:interests))
  	# 	@user.save
  	# else
  	# 	render 'edit'
  	# end
  end

  def save_interest
    @user = current_user
    new_interest = Interest.create(:name => params[:interest])
    @user.interests << new_interest
    render nothing: true
  end

  # def remove_interest
  #   @user = current_user
  #   @user.interests.delete(:name => params[:interest])
  #   render nothing: true
  # end

end