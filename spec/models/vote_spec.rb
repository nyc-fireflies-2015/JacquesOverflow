require 'rails_helper'

RSpec.describe Vote, type: :model do
    context 'contains valid data' do 	
	  it { expect(subject).to validate_presence_of(:value) }
	  it { expect(subject).to validate_inclusion_of(:value).in_array([1, -1]) }
	end

	context 'has correct associations' do 
		it { expect(subject).to belong_to(:voter) }
	end	

end
