require 'rails_helper'

RSpec.describe Question, type: :model do

	context 'contains valid data' do 	
	  it { expect(subject).to validate_presence_of(:content) }
	  it { expect(subject).to validate_presence_of(:title) }
	  it { expect(subject).to validate_length_of(:content) }
	  it { expect(subject).to validate_length_of(:title) }
	end

	context 'has correct associations' do 
	end	
end

