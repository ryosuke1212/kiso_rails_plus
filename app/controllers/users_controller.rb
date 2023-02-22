class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create] # this should only be used if you are allowing users to register themselves. 

  #end
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(login_url, flash:{success: t('.success')})
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :last_name, :first_name)
  end
end
