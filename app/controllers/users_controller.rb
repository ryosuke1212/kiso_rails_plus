class UsersController < ApplicationController
  #skip_before_action :require_login, only: [:index, :new, :create] # this should only be used if you are allowing users to register themselves. 

  #def email:string
  #end
#
  #def crypted_password:string
  #end
#
  #def salt:string
  #end
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    binding.pry
    @user = User.new(user_params)
    if @user.save
      redirect_to(login_url, notice: 'User was successfully created')
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :last_name, :first_name)
  end
end
