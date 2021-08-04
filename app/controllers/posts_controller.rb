class PostsController < ApplicationController

  USERS = {"role" => "Admin"}
  include PostsHelper
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :admin_user, only: [:index, :edit, :destroy]
  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = current_user.posts
  end

  # GET /posts/new
  def new
    # debugger
    @user = User.find(params[:id])
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    # debugger
    @user = User.find(params[:post][:user_id])
    @post = @user.posts.create(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: "Post #{full_name(@post)} was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    # debugger
    respond_to do |format|
      if @post.update(post_params)
        format.js {}
        format.html { redirect_to posts_path, notice: "Post #{full_name(@post)} was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.js {}
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def admin_user
      # if user_signed_in?
            if current_user.admin?
                return true
            else 
                flash[:alert] = "You have not permission for this page."
                redirect_to root_path
            end
      # else
      #   flash[:alert] = "You are not login, Please login."
      #   redirect_to root_path
      # end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id,:title, :description, :image)
    end
end
