class LikesController < ApplicationController
  before_action :find_post

  def index
  end

  def new 
  end

  def create
    # debugger
    @post.likes.create(user_id:current_user.id)
    redirect_to root_path(@post)
  end

  def destroy
    debugger
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to root_path(@post)
  end

  private

  def find_post
      @post = Post.find(params[:id])
  end

end
