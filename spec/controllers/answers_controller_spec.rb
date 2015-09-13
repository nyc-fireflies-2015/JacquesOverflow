require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  include SessionsHelper

  def post_answer
    @question = FactoryGirl.create(:question)
    @user = FactoryGirl.create(:user)
    log_in(@user)
    @answer = Answer.new(content: "This is my smart answer")
    @answer_attributes = @answer.attributes
  end

  def create_answer
    @question = FactoryGirl.create(:question)
    @user = FactoryGirl.create(:user)
    log_in(@user)
    @answer = @question.answers.create(content: "This is my smart answer")
    @answer_attributes = @answer.attributes
  end

  def edit_answer
    @question = FactoryGirl.create(:question)
    @user = FactoryGirl.create(:user)
    log_in(@user)
    @answer = @question.answers.create(content: "This is my smart answer")
    @new_content = {"content": "This is my changed response"}
  end

  def make_best_answer
    @question = FactoryGirl.create(:question)
    @user = FactoryGirl.create(:user)
    log_in(@user)
    @answer = @question.answers.create(content: "This is my smart answer")
  end

  describe 'POST #create' do
    it 'adds an answer to the question it is posting to' do
      post_answer
      expect{post :create, question_id: @question.id, answer: @answer_attributes}.to change{@question.answers.count}.by(1)
    end

    it 'redirects to question after answer' do
      post_answer
      post :create, question_id: @question.id, answer: @answer_attributes
      expect(response).to redirect_to(question_path(@question))
    end
  end

  describe 'DELETE #destroy' do
    it 'reduces answer count for question by 1' do
      create_answer
      expect{delete :destroy, question_id: @question.id, id: @answer.id}.to change{@question.answers.count}.by(-1)
    end

    it 'redirects to question after deletion' do
      create_answer
      delete :destroy, question_id: @question.id, id: @answer.id
      expect(response).to redirect_to(question_path(@question))
    end
  end

  describe 'PUT #update' do
    context 'user edits their response' do
      it 'changes answer content after editing it' do
        edit_answer
        put :update, question_id: @question.id, answer: {"content": "This is my changed response"}, id: @answer.id
        @answer.reload
        expect(@answer.content).to eq("This is my changed response")
      end

      it 'redirects to question after editing answer' do
        edit_answer
        put :update, question_id: @question.id, answer: {"content": "This is my changed response"}, id: @answer.id
        expect(response).to redirect_to(question_path(@question))
      end
    end

    context 'user makes an answer best answer' do
      it 'makes answer best answer' do
        make_best_answer
        put :update, question_id: @question.id, answer: {"best_answer": "true"}, id: @answer.id
        @question.reload
        expect(@question.best_answer_id).to eq(@answer.id)
      end

      it 'redirects to question after making an answer best answer' do
        make_best_answer
        put :update, question_id: @question.id, answer: {"best_answer": "true"}, id: @answer.id
        expect(response).to redirect_to(question_path(@question))
      end
    end
  end

end
