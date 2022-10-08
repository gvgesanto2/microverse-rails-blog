class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_user, only: %i[index show destroy]
  before_action :set_post, only: %i[show destroy]
  load_and_authorize_resource

  def index
    @posts = @user.get_most_recent_posts
  end

  def show
    @comments = @post.comments.includes(:author).most_recent_ones
  end

  def create
    post = Post.new(post_params)
    post.author = current_user

    respond_to do |format|
      if post.save
        format.html { redirect_to user_path(current_user), notice: 'Post was successfully created.' }
      else
        format.html { redirect_to user_path(current_user), alert: 'Error: post could not be created.' }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: 'Post was successfully deleted.' }
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:user_posts).permit(:title, :text)
  end
end
