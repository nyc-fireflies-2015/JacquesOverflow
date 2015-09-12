module ApplicationHelper
  def current_user
    session[:user_id]
  end
end
