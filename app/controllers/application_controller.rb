class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @user = User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_in_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def not_logged_in
    return if logged_in?
    redirect_to new_session_url
  end

  def logged_in
    return unless logged_in?
    redirect_to bands_url
  end
end
