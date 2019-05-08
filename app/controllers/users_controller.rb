class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      log_in_user!(@user)
      render text: 'You logged in!'
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