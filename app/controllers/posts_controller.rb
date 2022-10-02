class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.by_author(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    post = current_user.posts.new(strong_params)
    redirect_to user_path(current_user) if post.save
  end

  private

  def strong_params
    params.require(:user_posts).permit(:title, :text)
  end
end
