class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create], raise: false

  def new
  end

  def create
    @user = login(params[:email], params[:password])
    #binding.pry
    if @user
      redirect_back_or_to(root_path, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: 'Logged out!')
  end
end
