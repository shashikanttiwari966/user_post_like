
class WelcomeController < ApplicationController
  # protect_from_forgery except: :index

  def index
   @posts = Post.paginate(page: params[:page], per_page: 6)
   @postall = Post.all
   # @post = Post.search(params[:search])
  end

  def search
    # debugger
    if params[:search].blank?  
      redirect_to(root_path, alert: "Empty field!") and return  
    else  
      @parameter = params[:search].downcase  
      @posts = Post.all.where("lower(title) LIKE :search", search: "%#{@parameter}%").paginate(page: params[:page], per_page: 3)  
      if @posts.blank?
         @user = User.all.where("lower(email) LIKE :search", search: "%#{@parameter}%").first
         if !@user.blank?  
            @results = @user.posts.paginate(page: params[:page], per_page: 3)
         else
            @show = "No item here"
         end
      end  
    end 
  end
end
