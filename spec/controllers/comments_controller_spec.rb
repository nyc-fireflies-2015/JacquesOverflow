require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	 include SessionsHelper

	 let(:user) { FactoryGirl.create :user }
	 let(:comment) {FactoryGirl.create :comment}

	 def create_question_comment
		log_in(user)
		@question = FactoryGirl.create(:question)
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
  end  

end
