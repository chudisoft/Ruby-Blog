class LikesController < ApplicationController
  def create
    post = Post.find(params[:id])
    like = post.likes.build(user: current_user)

    if like.save
      flash[:success] = 'Post liked!'
    else
      flash[:error] = 'Error liking the post.'
    end
    redirect_to request.referer
  end
end
