class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.by_author(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end
end
