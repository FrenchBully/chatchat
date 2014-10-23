class InterestsController < ApplicationController
  def index
  end

  def destroy
		@interest = Interest.find(params[:id])
		@interest.destroy
		render nothing: true
	end
end
