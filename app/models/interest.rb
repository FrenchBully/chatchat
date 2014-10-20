class Interest < ActiveRecord::Base
  has_and_belongs_to_many :user, through: :interests_users

  def create
  	@interest = params[:interest].split(/,\s*/)
	@interest.each do |i|
	  	new_int = Interest.new(:interest => i)
	  	new_int.save
	end
	# redirect_to interests_path
  end

end
