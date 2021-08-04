class LikesController < ApplicationController
  before_action :find_post, only: [:create]

  def index
  end

  def new 
  end

  def create
    if @post.present?
      @like = @post.likes.create(user_id:current_user.id)
      #redirect_to root_path(@post), notice:"Liked post! #{@post.title}"
    elsif @comment.present? 
      @like =@comment.likes.create(user_id:current_user.id)
      # redirect_to root_path(@comment), notice:"Liked comment! #{@comment.comment}"
    end 
  end

  def create_like_comment
    # if @comment.present? 
    #   @like =@comment.likes.create(user_id:current_user.id)
    # end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    @post = Post.find(params[:post_id])
    # @comment = Comment.find(params[:comment_id])
    #redirect_to root_path
  end

  def destroy_like_comment
    
  end

  private

  def find_post
    # debugger
    if post = (params[:like_on_type] == "Post")
      @post = Post.find(params[:post_id])
    elsif comment = (params[:like_on_type] == "Comment")
      @comment = Comment.find(params[:comment_id])
    end
  end

end
