require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  def create_user
    @user = FactoryGirl.create(:user)
    @user_attributes = @user.attributes
  end

  describe '#new' do
    it 'assigns a new user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe '#create' do
    it 'creates a new user' do
      get :new
      create_user
      post :create, user: @user_attributes
      expect(User.last.username).to eq(@user.username)
      expect(User.last.email).to eq(@user.email)
    end

    it "redirects user to the homepage if signup successful" do
      get :new
      create_user
      post :create, user: @user_attributes
      expect(response).to redirect_to root_path
    end
  end

  describe '#show' do
    it 'shows the user profile page' do
      create_user
      get :show, id: @user
    end

    it "shows user's questions ans answers" do
      create_user
      get get :show, id: @user

    end
  end

end
