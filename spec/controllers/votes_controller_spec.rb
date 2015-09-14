require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  def create_question_upvote
    @question = FactoryGirl.create(:question)
    @user = FactoryGirl.create(:user)
    @vote = Vote.new(value: 1)
    @vote_attributes = @vote.attributes
  end

  def create_question_downvote
    @question = FactoryGirl.create(:question)
    @user = FactoryGirl.create(:user)
    @vote = Vote.new(value: -1)
    @vote_attributes = @vote.attributes
  end

  def create_answer_upvote
    @question = FactoryGirl.create(:question)
    @answer = @question.answers.create(content: "This is my answer")
    @user = FactoryGirl.create(:user)
    @vote = Vote.new(value: 1)
    @vote_attributes = @vote.attributes
  end

  def create_answer_downvote
    @question = FactoryGirl.create(:question)
    @answer = @question.answers.create(content: "This is my answer")
    @user = FactoryGirl.create(:user)
    @vote = Vote.new(value: -1)
    @vote_attributes = @vote.attributes
  end

  describe "#new" do
  end


  describe 'POST #create' do
    context 'with question params' do
      it 'adds a vote to a question' do
        create_question_upvote
        expect{post :create, question_id: @question.id, vote: @vote_attributes}.to change{@question.votes.count}.by(1)
      end

      it 'increases question rating by one if upvote' do
        create_question_upvote
        expect{post :create, question_id: @question.id, vote: @vote_attributes}.to change{@question.rating}.by(1)
      end

      it 'decreases question rating by one if downvote' do
        create_question_downvote
        expect{post :create, question_id: @question.id, vote: @vote_attributes}.to change{@question.rating}.by(-1)
      end


      it 'redirects to question after upvote' do
        create_question_upvote
        post :create, question_id: @question.id, vote: @vote_attributes
        expect(response).to redirect_to(question_path(@question))
      end
    end

    context 'with answer params' do
      it 'adds a vote to an answer' do
        create_answer_upvote
        expect{post :create, answer_id: @answer.id, vote: @vote_attributes}.to change{@answer.votes.count}.by(1)
      end

      it 'increases answer rating by one if upvote' do
        create_answer_upvote
        expect{post :create, answer_id: @answer.id, vote: @vote_attributes}.to change{@answer.rating}.by(1)
      end

      it 'decreases answer rating by one if downvote' do
        create_answer_downvote
        expect{post :create, answer_id: @answer.id, vote: @vote_attributes}.to change{@answer.rating}.by(-1)
      end


      it 'redirects to question after vote' do
        create_answer_upvote
        post :create, answer_id: @answer.id, vote: @vote_attributes
        expect(response).to redirect_to(question_path(@question))
      end
    end

  end


end

