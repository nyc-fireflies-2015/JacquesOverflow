class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      log_in(user)
      redirect_to root_path, notice: "Account Has Created!!"
    else
      flash[:registration_error] = user.errors.full_messages
      redirect_to register_path
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

      redirect_to edit_user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :bio, :avatar_url)
  end
end
