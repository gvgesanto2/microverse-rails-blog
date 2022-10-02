class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @current_user = current_user
    @user = User.find(params[:id])
  end
end
