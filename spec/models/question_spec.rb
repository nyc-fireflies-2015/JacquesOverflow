require 'rails_helper'

RSpec.describe Question, type: :model do

	context 'contains valid data' do 	
	  it { expect(subject).to validate_presence_of(:content) }
	  it { expect(subject).to validate_presence_of(:title) }
	  it { expect(subject).to validate_length_of(:content).is_at_most(5000) }
	  it { expect(subject).to validate_length_of(:title).is_at_most(150) }
	end

	context 'has correct associations' do 
		it { expect(subject).to have_many(:answers) }
		it { expect(subject).to have_many(:comments) }
		it { expect(subject).to have_many(:votes) }
		it { expect(subject).to belong_to(:submitter) }
	end	

	let(:question) { FactoryGirl.create(:question) }

	describe '#rating' do 
		it 'should have a rating of 0 if it has 1 upvote and 1 downvote' do
			question.votes.create(value: 1)
			question.votes.create(value: -1)
			expect(question.rating).to eq(0)
		end	

		it 'should have a rating of -2 with two downvotes' do
			2.times {question.votes.create(value: -1)}
			expect(question.rating).to eq(-2)
		end
		
		it 'should have a rating of 4 with four upvotes' do
			4.times {question.votes.create(value: 1)}
			expect(question.rating).to eq(4)
		end	
	end	

	describe "#has_best_answer?" do 
		it 'should return false upon creation' do 
			expect(question.has_best_answer?).to be_falsey
		end
		
		it 'should return true after user chooses best answer' do
			answer = question.answers.create(FactoryGirl.attributes_for(:answer).merge(best_answer: true))
			question.best_answer_id = answer.id
			expect(question.has_best_answer?).to be_truthy
		end	
	end	
end

