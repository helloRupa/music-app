class UsersController < ApplicationController
  before_action :logged_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      msg = ActivationMailer.activation_email(@user)
		  msg.deliver_now
      flash[:error] = 'Please click the link in your activation email'
      redirect_to new_session_url
    else
      flash.now[:error] = @user.errors
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end