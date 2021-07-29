class CommentsController < ApplicationController

	def new
  	@user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
  	@comment = Comment.new
  end

  def create
  	us= User.find(params[:comment][:user_id])
  	po = Post.find(params[:comment][:post_id])
  	@comment = Comment.create(user:us, post:po, comment:params[:comment][:comment])
  	return redirect_to root_path
  end

  def show
  	# debugger
  	@post = Post.find(params[:post_id])
  	@comments = @post.comments
  end

end
