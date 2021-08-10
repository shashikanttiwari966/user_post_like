
class WelcomeController < ApplicationController
  before_action :admin_user, only: [:show_users]

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

  def show_pdf
    
  end

  def show_users
    @users = User.all
    # respond_to do |format|
    #   format.html
    #   format.pdf
    #       pdf = Prawn::Document.new
    #       pdf.text "hello rails"
    #       send_data pdf.render
    # end
  end

  private

  def admin_user
      if user_signed_in?
        if current_user.admin?
          return true
        else 
          flash[:alert] = "You have not permission for this page."
          redirect_to root_path
        end
      end
  end
end
