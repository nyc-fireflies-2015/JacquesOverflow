require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
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
end
