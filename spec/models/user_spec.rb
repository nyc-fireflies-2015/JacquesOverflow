require 'rails_helper'

RSpec.describe User, type: :model do
  context 'contains valid data' do
	  it { expect(subject).to validate_presence_of(:username) }
	  it { expect(subject).to validate_presence_of(:email) }
	  it { expect(subject).to validate_presence_of(:password).on(:create) }
	  it { expect(subject).to validate_length_of(:username).is_at_most(50) }
	 	it { expect(subject).to validate_length_of(:email).is_at_most(50) }
	 	it { expect(subject).to validate_length_of(:avatar_url).is_at_most(500) }
 		it { expect(subject).to validate_length_of(:bio).is_at_most(500) }
 		it { expect(subject).to validate_length_of(:password).is_at_least(6).on(:create) }
		it { expect(subject).to have_secure_password }
		it { expect(FactoryGirl.create(:user)).to validate_uniqueness_of(:email) }
		it { expect(FactoryGirl.create(:user)).to validate_uniqueness_of(:username) }
	end

	context 'has correct associations' do
		it { expect(subject).to have_many(:questions) }
		it { expect(subject).to have_many(:answers) }
		it { expect(subject).to have_many(:comments) }
		it { expect(subject).to have_many(:votes) }
	end

	let(:user) { FactoryGirl.create(:user) }

	describe '#posted_question?' do 
		it 'should return true if user posted question' do 
			question = user.questions.create(FactoryGirl.attributes_for(:question))
			expect(user.posted_question?(question)).to be_truthy
		end
	end
	
	describe '#posted_answer?' do 
		it 'should return true if user posted answer' do 
			answer = user.answers.create(FactoryGirl.attributes_for(:answer))
			expect(user.posted_answer?(answer)).to be_truthy
		end	
	end

	describe '#posted_comment?' do 
		it 'should return true if user posted comment' do 
			comment = user.comments.create(FactoryGirl.attributes_for(:comment))
			expect(user.posted_comment?(comment)).to be_truthy
		end	
	end

	describe '#voted_on_question?' do
	end
	
	describe '#voted_on_answer?' do
	end

	describe '#authorized_to_vote_on_answer?' do 
	end	

	describe '#authorized_to_vote_on_answer?' do 
	end	

	describe '#timestamp' do 
	end
	
	describe "#reputation" do 
	end	

end
