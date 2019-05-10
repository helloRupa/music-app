class UsersController < ApplicationController
  before_action :logged_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      @url = activate_users_url(activation_token: @user.activation_token)
      render :fake_email
    else
      flash.now[:error] = @user.errors
      render :new
    end
  end

  def activate
    user = User.find_by_activation_token(params[:activation_token])

    if user
      user.activated = true
      user.save
    end

    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end