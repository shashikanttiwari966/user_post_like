class RegistrationsController < Devise::RegistrationsController
  def new
    @plan = params[:plan]
    super
  end

  def create
    plan_id = params[:user][:plan]
    trial_days = Stripe::Plan.retrieve(plan_id).trial_period_days
  	super
  	if !@user.blank?
  	  @role = Role.find_by_name(params[:user][:role])
  	  @user_roles = @user.user_roles.create(role:@role)
      @customer = Stripe::Customer.create(email:@user.email)
      @user.update(stripe_id:@customer.id)
      #create sripe subscription 
      stripe_subscription = Stripe::Subscription.create({customer: @customer.id,items: [{plan: plan_id}],trial_end: (Time.now+trial_days.day).to_i
      })
      
      if stripe_subscription.items.first.plan.trial_period_days == nil
        trial = false
      else
        trial = true
      end
      @user.create_subscription(stripe_plna_id:stripe_subscription.items.first.plan.id, stripe_subscription_id:stripe_subscription.id, is_trial: trial,trial_expire_at:Time.at(stripe_subscription.trial_end),plan_expires_at:Time.at(stripe_subscription.current_period_end), status:stripe_subscription.status)               
      sign_in @user
  	  redirect_to root_path
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
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