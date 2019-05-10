class SessionsController < ApplicationController
  before_action :logged_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    err = !@user ? 'Wrong username or password' : 'Please click the link in your activation email'

    if @user && @user.activated
      log_in_user!(@user)
      redirect_to bands_url
    else
      flash.now[:error] = err
      render :new
    end
  end

  def destroy
    user = current_user

    if user
      user.reset_session_token!
      session[:session_token] = nil
    end

    redirect_to new_session_url
  end
end