class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    @comment = Comment.new(post:, author: current_user, text: params[:text])
    redirect_to user_post_path(current_user, post) if @comment.save
  end

  def destroy
    user = User.find(params[:user_id])
    comment = Comment.find(params[:id])
    comment.destroy

    respond_to do |format|
      format.html { redirect_to user_post_path(user, comment.post_id), notice: 'Comment was successfully deleted.' }
    end
  end

  private

  def strong_params
    params.require(:user_post_comments).permit(:post_id, :text)
  end
end
