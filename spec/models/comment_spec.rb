require 'rails_helper'

RSpec.describe Comment, type: :model do
    context 'contains valid data' do 	
	  it { expect(subject).to validate_presence_of(:content) }
	  it { expect(subject).to validate_length_of(:content) }
	end

	context 'has correct associations' do 
		it { expect(subject).to belong_to(:commentator) }
	end	
end
