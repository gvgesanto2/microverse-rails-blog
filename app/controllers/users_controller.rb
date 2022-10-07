class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.get_most_recent_posts(3).includes(:author)
  end
end
