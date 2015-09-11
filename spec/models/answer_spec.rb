require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'contains valid data' do 	
	  it { expect(subject).to validate_presence_of(:content) }
	  it { expect(subject).to validate_length_of(:content).is_at_most(2000).on(:create) }
	end

	context 'has correct associations' do 
		it { expect(subject).to have_many(:votes) }
		it { expect(subject).to have_many(:comments) }
		it { expect(subject).to belong_to(:question) }
		it { expect(subject).to belong_to(:responder) }
	end	
end
