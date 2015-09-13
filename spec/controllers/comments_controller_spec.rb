require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	 include SessionsHelper

	 let(:user) { FactoryGirl.create :user }
	 let(:comment) { FactoryGirl.create :comment }

	 def create_question_comment
		log_in(user)
		@question = FactoryGirl.create(:question)
		@comment_attributes = FactoryGirl.attributes_for(:comment)
	 end	

	 def create_answer_comment
	 	log_in(user)
	 	@question = FactoryGirl.create(:question)
		@answer = @question.answers.create(FactoryGirl.attributes_for(:answer))
		@comment_attributes = FactoryGirl.attributes_for(:comment)
	 end	

	 describe "POST #create" do
      it "redirects to root if not logged in" do
      	question = FactoryGirl.create(:question)
        post :create, comment: FactoryGirl.attributes_for(:comment), question_id: question
        expect(response).to redirect_to root_path
      end

    context "valid attributes for question comment" do
      it "creates a new question comment" do
        create_question_comment
        expect{post :create, comment: @comment_attributes, question_id: @question}.to change{@question.comments.count}.by(1)
        expect(Comment.last).to have_attributes(@comment_attributes)
      end

      it "redirects back to the question show page" do
        create_question_comment
        post :create, comment: @comment_attributes, question_id: @question
        expect(response).to redirect_to(question_path(@question))
      end
    end

    context "valid attributes for answer comment" do
      it "creates a new answer comment" do
        create_answer_comment
        expect{post :create, comment: @comment_attributes, answer_id: @answer.id}.to change{@answer.comments.count}.by(1)
        expect(Comment.last).to have_attributes(@comment_attributes)
      end

      it "redirects back to the question show page" do
        create_answer_comment
        post :create, comment: @comment_attributes, answer_id: @answer.id
        expect(response).to redirect_to(question_path(@question))
      end
    end

  end  

end
