class SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    # debugger
    pass = sign_in_params[:password]
    user = sign_in_params[:login]
    @user = User.where(["email = ? or user_name = ?", params[:user][:login], params[:user][:login]]).first

    if user.blank?
      flash[:alert] = "Username OR Email can't be blank!"
      redirect_to user_session_path
    elsif !@user.blank? 
      if !pass.blank?
          if @user.valid_password?(pass) 
            sign_in @user
            redirect_to root_path
          else
            flash[:alert] = "Invalid Password !"
            redirect_to user_session_path
          end
      else
        flash[:alert] = "Password can't be blank!"
        redirect_to user_session_path  
      end  
    else
      flash[:alert] = "Invalid Username OR Email!"
      redirect_to user_session_path
    end  
   end 
end
