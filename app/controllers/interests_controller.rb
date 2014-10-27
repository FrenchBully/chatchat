class InterestsController < ApplicationController
  def index
  end

  # via ajax in user profile
  def save_interest
    @user = current_user
    if @user.interests.count < 5

      new_interest = Interest.find_or_create_by(name: params[:interest])
      # add join only if it join doesn't exist
      if @user.interests.include? new_interest
        new_interest = {new_interest: nil, error: "you already added that interest"}
      else  
        @user.interests << new_interest 
      end
      
      # response to jQuery ajax request
      respond_to do |format|
        format.json { render json: new_interest }
      end
    else
      flash[:alert] = 'no more interests, yo!'
    end
  end

  # via ajax in user profile
  def destroy
		@interest = Interest.find(params[:id])
		@interest.destroy
		render nothing: true
	end
end
