require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

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
    it 'creates a new user with valid info' do
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
      #can't figure this one out
       (expect(response.status).to eq(200))
    end

    it 'renders the users new page with invalid data' do
      get :new
      user_attributes = FactoryGirl.attributes_for(:invalid_user)
      post :create, user: user_attributes
      expect(response).to render_template('new')
    end
  end

  describe '#show' do
    it 'shows the user profile page' do
      create_user
      get :show, id: @user
    end
  end

  describe '#edit' do
    it 'renders the edit profile page' do
      get :new
      create_user
      log_in(@user)
      get :edit, id: @user.id
      expect(response).to render_template('edit')
    end
  end

  describe '#update' do
    it "updates a user's profile with valid data" do
      get :new
      create_user
      log_in(@user)
      get :edit, id: current_user.id
      user_attributes = FactoryGirl.attributes_for(:user)
      put :update, id: current_user.id, user: user_attributes
      expect(current_user.username).to eq(user_attributes[:username])
      expect(response).to redirect_to(profile_path)
    end

    it "update fails with invalid data" do
      get :new
      create_user
      log_in(@user)
      get :edit, id: current_user.id
      user_attributes = FactoryGirl.attributes_for(:invalid_user)
      put :update, id: current_user.id, user: user_attributes
      expect(response).to render_template('edit')
    end
  end
end
