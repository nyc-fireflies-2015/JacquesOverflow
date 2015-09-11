require 'rails_helper'

RSpec.describe User, type: :model do
  context 'contains valid data' do 	

	  it { expect(subject).to validate_presence_of(:username) }
	  it { expect(subject).to validate_presence_of(:email) }
	  it { expect(subject).to validate_presence_of(:password) }
	  it { expect(subject).to validate_length_of(:username).is_at_most(50) }
	 	it { expect(subject).to validate_length_of(:email).is_at_most(50) }
	 	it { expect(subject).to validate_length_of(:avatar_url).is_at_most(50) }
 		it { expect(subject).to validate_length_of(:bio).is_at_most(500) }
 		it { expect(subject).to validate_length_of(:password).is_at_least(6) }
		it { expect(subject).to have_secure_password }
		it { expect(User.new(username:"derpson")).to validate_uniqueness_of(:email) }
		it { expect(User.new(email:"blah@gmail.com")).to validate_uniqueness_of(:username) }
	end

	context 'has correct associations' do 
		it { expect(subject).to have_many(:questions) }
		it { expect(subject).to have_many(:answers) }
		it { expect(subject).to have_many(:comments) }
		it { expect(subject).to have_many(:votes) }
	end	

end
