require 'rails_helper'

describe Interest do

	it "must have a name" do
		interest = Interest.new(name: 'TDD')
		expect(interest).to be_valid
	end

	it "belongs to a user"

	it "can belong to many users"

end