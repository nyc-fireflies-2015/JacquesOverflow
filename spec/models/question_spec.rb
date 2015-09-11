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
end

