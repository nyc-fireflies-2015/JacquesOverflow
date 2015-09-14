require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  include SessionsHelper

  let(:question) { FactoryGirl.create :question }
  let(:user) { FactoryGirl.create :user }

  describe "GET #index" do
    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
    it "displays questions in order of recency" do 
      get :index
      expect(assigns(:questions)).to eq(Question.order_by_recent)
    end  
  end

  describe "GET #show" do
    it "renders the :show view" do
      get :show, id: question
      expect(response).to render_template :show
    end

    it "located the requested @question" do
      get :show, id: question
      expect(assigns(:question)).to eq(question)
    end
  end

  describe "GET #new" do
    it "renders the :new view when logged in" do
      log_in(user)
      get :new
      expect(response).to render_template :new
    end

    it "redirects to root if not logged in" do
      get :new
      expect(response).to redirect_to root_path
    end
  end

  describe "POST #create" do
    context "valid attributes" do
      it "redirects to root if not logged in" do
        post :create, question: FactoryGirl.attributes_for(:question)
        expect(response).to redirect_to root_path
      end

      it "creates a new question" do
        log_in(user)
        question_attributes = FactoryGirl.attributes_for(:question)
        post :create, question: question_attributes
        expect(Question.last).to have_attributes question_attributes
      end

      it "redirects to new question show view" do
        log_in(user)
        post :create, question: FactoryGirl.attributes_for(:question)
        expect(response).to redirect_to(question_path(Question.last))
      end
    end

    context "invalid attributes" do
      it "doesn't create a post with invalid attributes" do
        log_in(FactoryGirl.create(:user))
        question_attributes = { title: "Title", content: nil }
        post :create, question: question_attributes
        expect(response).to redirect_to new_question_path
      end
    end
  end

  describe "GET #edit" do
    it "renders the :edit view when logged in" do
      log_in(user)
      get :edit, id: question
      expect(response).to render_template :edit
    end

    it "located the requested @question" do
      get :edit, id: question
      expect(assigns(:question)).to eq(question)
    end

    it "redirects to root if not logged in" do
      get :edit, id: question
      expect(response).to redirect_to root_path
    end
  end


  describe "PUT #update" do
    before :each do
      @question = FactoryGirl.create(:question, title: "Title", content: "content")
    end

    context "valid attributes" do
      it "located the requested @question" do
        put :update, id: @question
        expect(assigns(:question)).to eq(@question)
      end

      it "changes @question's attributes" do
        log_in(user)
        put :update, id: @question, question: FactoryGirl.attributes_for(:question, title: "Updated Title")
        @question.reload
        expect(@question.title).to eq("Updated Title")
      end

      it "redirects to the updated question" do
        log_in(user)
        put :update, id: @question, question: FactoryGirl.attributes_for(:question)
        expect(response).to redirect_to @question
      end

      it "redirects root page if not logged in" do
        put :update, id: @question
        expect(response).to redirect_to root_path
      end
    end

    context "invalid attributes" do
      it "locates the requested @question" do
        put :update, id: @question
        expect(assigns(:question)).to eq(@question)
      end

      it "does not change @question's attributes" do
        log_in(user)
        put :update, id: @question, question: FactoryGirl.attributes_for(:question, title: nil)
        @question.reload
        expect(@question.title).to eq("Title")
        expect(@question.content).to eq("content")
      end

      it "redirects to edit view" do
        log_in(user)
        put :update, id: @question, question: FactoryGirl.attributes_for(:question, title: nil)
        expect(response).to redirect_to edit_question_path(@question)
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @question = FactoryGirl.create(:question)
    end

    it "redirects to root page if not logged in" do
      delete :destroy, id: @question
      expect(response).to redirect_to root_path
    end

    it "does not delete question when user is not logged in" do
      expect {
        delete :destroy, id: @question
        }.not_to change(Question, :count)
    end

    it "located the requested question" do
      log_in(user)
      delete :destroy, id: @question
      expect(assigns(:question)).to eq(@question)
    end

    it "deletes the question" do
      log_in(user)
      expect{
        delete :destroy, id: @question
      }.to change(Question, :count).by(-1)
    end

    it "redirects to root page when question is deleted" do
      log_in(user)
      delete :destroy, id: @question
      expect(response).to redirect_to(root_path)
    end
  end
end
