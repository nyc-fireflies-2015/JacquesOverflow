require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'contains valid data' do 	
	  it { expect(subject).to validate_presence_of(:content) }
	  it { expect(subject).to validate_length_of(:content).is_at_most(2000) }
	end

	context 'has correct associations' do 
		it { expect(subject).to have_many(:votes) }
		it { expect(subject).to have_many(:comments) }
		it { expect(subject).to belong_to(:question) }
		it { expect(subject).to belong_to(:responder) }
	end	

	let(:answer) { FactoryGirl.create(:answer) }

	describe '#rating' do 
		it 'should have a rating of 0 if it has 1 upvote and 1 downvote' do
			answer.votes.create(value: 1)
			answer.votes.create(value: -1)
			expect(answer.rating).to eq(0)
		end	

		it 'should have a rating of -2 with two downvotes' do
			2.times {answer.votes.create(value: -1)}
			expect(answer.rating).to eq(-2)
		end
		
		it 'should have a rating of 4 with four upvotes' do
			4.times {answer.votes.create(value: 1)}
			expect(answer.rating).to eq(4)
		end	
	end	
end
