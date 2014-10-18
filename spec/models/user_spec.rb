require 'rails_helper'

describe User do

	it "should be not be valid without an email address" do
		user = User.new(name: 'Steve', password: 'bozotheclown', meetup_id: '123456')
		expect(user).to be_invalid
	end

	it "should have a password 8-digits or longer" do
		user = User.new(name: 'Steve', email: 'steve@steve.com', password: '1234567', meetup_id: '123456')
		expect(user).to be_invalid
	end

	it "should be not be valid without a name" do
		user = User.new(email: 'steve@steve.com', password: 'bozotheclown', meetup_id: '123456')
		expect(user).to be_invalid
	end

	it "should require a meetup_id" do
		user = User.new(name: 'Steve', email: 'steve@steve.com', password: 'bozotheclown', meetup_id: '123456')
		expect(user).to be_valid
	end

	context 'when logged in' do
		# we need a line to log the user in
		it { is_expected.to respond_with 200 }
	end

	context 'when logged out' do
		# need a line to log the user out
		it { is_expected.to respond_with 401 }
	end

	it "should have many interests" do
		expect(user).to have_many(:interests)
	end

end
