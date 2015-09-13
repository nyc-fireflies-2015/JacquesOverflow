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

	 def destroy_question_comment
	 	log_in(user)
		@question = FactoryGirl.create(:question)
		@comment = FactoryGirl.create(:comment)
		@question.comments << @comment
	 end
	 
	 def destroy_answer_comment
	 	log_in(user)
		@question = FactoryGirl.create(:question)
		@answer = @question.answers.create(FactoryGirl.attributes_for(:answer))
		@comment = FactoryGirl.create(:comment)
		@answer.comments << @comment
	 end	

	 describe "#create" do
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

  describe "#destroy" do 
    it "redirects to root page if not logged in" do
      delete :destroy, id: comment, question_id: FactoryGirl.create(:question)
      expect(response).to redirect_to root_path
    end

    context "deletes comments from a question" do 
    	it "deletes the question comment" do 
    		destroy_question_comment
    		expect{delete :destroy, id: @comment, question_id: @question}.to change{@question.comments.count}.by(-1)
    	end
    	
    	it "redirects to the question show page after deletion" do
    		destroy_question_comment
    		delete :destroy, id: @comment, question_id: @question
    		expect(response).to redirect_to(question_path(@question))
    	end	
    end
    
    context "deletes comments from an answer" do 
    	it "deletes the answer comment" do 
    		destroy_answer_comment
    		expect{delete :destroy, id: @comment, answer_id: @answer}.to change{@answer.comments.count}.by(-1)
    	end
    	
    	it "redirects to the answer show page after deletion" do
    		destroy_answer_comment
    		delete :destroy, id: @comment, answer_id: @answer
    		expect(response).to redirect_to(question_path(@question))
    	end	
    end	

  end	

end
