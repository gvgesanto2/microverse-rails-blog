class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.by_author(params[:user_id])
  end

  def show
    @current_user = current_user
    @post = Post.find(params[:id])
  end

  def create
    post = Post.new(author: current_user, title: params[:user_posts][:title], text: params[:user_posts][:text])
    redirect_to user_path(current_user) if post.save
  end

  private

  def strong_params
    params.require(:user_posts).permit(:title, :text)
  end
end
