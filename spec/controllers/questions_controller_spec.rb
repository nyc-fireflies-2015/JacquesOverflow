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
  end

  describe "GET #show" do
    it "renders the :show view" do
      get :show, id: question
      expect(response).to render_template :show
    end

    it "assigns the requested question to @question" do
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
end
