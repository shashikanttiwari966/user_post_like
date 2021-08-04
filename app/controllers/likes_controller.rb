class LikesController < ApplicationController
  before_action :find_post, only: [:create]

  def index
  end

  def new 
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create(user_id:current_user.id)
    #redirect_to root_path(@post), notice:"Liked post! #{@post.title}"
  end

  def create_like_comment
    @comment = Comment.find(params[:comment_id])
    @like =@comment.likes.create(user_id:current_user.id)
    # redirect_to root_path(@comment), notice:"Liked comment! #{@comment.comment}"
  end

  def destroy
    # debugger
    @like = Like.find(params[:id])
    # @like = Like.find_by(id: params[:id],user_id:current_user.id)
    if @like.present?
      @like.destroy
    end
    @post = Post.find(params[:post_id])
    #redirect_to root_path
  end

  def destroy_like_comment
    @like = Like.find(params[:id])
    @like.destroy
    #redirect_to root_path
    @comment = Comment.find(params[:comment_id])
  end

  private

  def find_post
    # debugger
      
  end

end
