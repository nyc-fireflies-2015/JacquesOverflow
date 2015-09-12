class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to root_url, notice: "Login Successful!"
    else
      redirect_to login_path, flash: {error: 'Login Failed!'}
    end
  end

  def destroy
    log_out
    flash[:notice] = "You have successfully logged out."
    redirect_to login_path
  end
end
