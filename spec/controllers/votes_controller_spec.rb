require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  def create_question_upvote
    @question = FactoryGirl.create(:question)
    @user = FactoryGirl.create(:user)
    @vote = Vote.new(value: 1)
    @vote_attributes = @vote.attributes

  end

  describe "#new" do
  end


  describe 'POST #create' do
    context 'with question params' do
      it 'adds a vote to a question' do
        create_question_upvote
        post :create, question_id: @question.id, vote: @vote_attributes
        expect(@question.votes.count).to eq(1)
      end
    end

    context 'with answer params' do
    end

  end


end


# describe '#create' do
#     it 'changes the total number of articles' do
#       expect do
#         post :create, {article: FactoryGirl.attributes_for(:article)}
#       end.to change{Article.all.length}
#     end
#   end

  # describe "#create" do
  #   it 'redirects to root_path after voting on a question' do
  #     expect do
  #       question = FactoryGirl.create(:question)
  #       user = FactoryGirl.create(:user)
  #       vote = question.votes.build(value: 1, voter: user)
  #       post :create, {vote: vote.create(value:1)}
  #     end.to change{Vote.all.length}
  #   end
