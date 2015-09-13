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
	let(:question) { FactoryGirl.create(:question) }
	let(:answer) { FactoryGirl.create(:answer) }
	let(:comment) { FactoryGirl.create(:comment) }

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
		it 'should return true if user already voted on question' do 
			question.votes.create(value: 1, voter: user)
			expect(user.voted_on_question?(question)).to be_truthy
		end	
	end
	
	describe '#voted_on_answer?' do
		it 'should return true if user already voted on answer' do 
			answer.votes.create(value: 1, voter: user)
			expect(user.voted_on_answer?(answer)).to be_truthy
		end	
	end

	describe '#authorized_to_vote_on_question?' do 
		it 'should return false if user posted question' do
			question = user.questions.create(FactoryGirl.attributes_for(:question)) 
			expect(user.authorized_to_vote_on_question?(question)).to be_falsey
		end
		
		it 'should return false if user already voted on question' do
			question.update_attributes(submitter: FactoryGirl.create(:user))
			question.votes.create(value: 1, voter: user)
			expect(user.authorized_to_vote_on_question?(question)).to be_falsey
		end	
	end	

	describe '#authorized_to_vote_on_answer?' do 
		it 'should return false if user posted question' do
			answer = user.answers.create(FactoryGirl.attributes_for(:answer)) 
			expect(user.authorized_to_vote_on_answer?(answer)).to be_falsey
		end

		it 'should return false if user already voted on answer' do
			answer.update_attributes(responder: FactoryGirl.create(:user))
			answer.votes.create(value: 1, voter: user)
			expect(user.authorized_to_vote_on_answer?(answer)).to be_falsey
		end	
	end

	describe '#reputation' do 
		it 'should return 75 if user has posted one question and one answer each with a rating of 5' do 
			answer = user.answers.create(FactoryGirl.attributes_for(:answer))
			question = user.questions.create(FactoryGirl.attributes_for(:question))
			5.times {answer.votes.create(value:1, voter: FactoryGirl.create(:user))}
			5.times {question.votes.create(value:1, voter: FactoryGirl.create(:user))}
			expect(user.reputation).to eq(75)
		end
	end	
end
