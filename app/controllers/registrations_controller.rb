class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
  	super
  	if !@user.blank?
  	  @role = Role.find_by_name(params[:user][:role])
  	  @user_roles = @user.user_roles.create(role:@role)
  	  # flash[:notice] = "Successfully create user role."
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    debugger
    @user = User.find(params[:user][:id])
    @user = @user.update(account_update_params)
    redirect_to root_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private

  def account_update_params
    params.require(:user).permit(:id, :user_name, :email, :admin, :role, :password_confirmation, :current_password)
  end

end 