class CommentsController < ApplicationController
  before_action :find_user

  def new
    @post = Post.find(params[:id])
    @comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:id])
    @comment = @post.comments.new(comment_params)
    @comment.user = @user

    if @comment.save
      flash[:notice] = 'Comment created successfully.'
      redirect_to user_post_path(@user, @post)
    else
      puts "Comment not saved. Errors: #{comment.errors.full_messages}" # Add this line for debugging
      render 'new'
    end
  end

  private

  def find_user
    @user = current_user
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
