class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      log_in(user)
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: current_user.id)
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to profile_path
    else
      #error message
      Rails.logger.info(@user.errors.messages.inspect)
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :bio, :avatar_url)
  end
end
