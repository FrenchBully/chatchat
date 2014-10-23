class Interest < ActiveRecord::Base
  has_and_belongs_to_many :user, through: :interests_users
  validates :name, presence: true, uniqueness: {message: "You've already entered this topic"}
  # before_create :validate_count

  def create
  	@interest = params[:interest].split(/,\s*/)
	@interest.each do |i|
	  	new_int = Interest.new(:interest => i)
	  	new_int.save
	end
	# redirect_to interests_path
  end

end
