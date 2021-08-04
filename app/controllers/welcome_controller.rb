
class WelcomeController < ApplicationController
  # protect_from_forgery except: :index

  def index
   @posts = Post.paginate(page: params[:page], per_page: 6)
   @postall = Post.all
  end
end
