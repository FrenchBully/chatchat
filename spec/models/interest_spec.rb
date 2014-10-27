require 'rails_helper'
require 'shoulda/matchers'

describe Interest do

	it "must have a name" do
		interest = Interest.new(name: 'TDD')
		expect(interest).to be_valid
	end

  it { should have_and_belong_to_many(:user) }
	
  it { should validate_uniqueness_of(:name).with_message("You've already entered this topic")}

end