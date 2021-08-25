class SubscriptionsController < ApplicationController
  def index
    @subscription = current_user.subscription
  end

  def new
    @user = User.find(params[:id])
    @subscription = Subscription.new
  end

  def create
    @user = User.find_by(user_name:params[:subscription][:user_name])
    @subscription = @user.create_subscription(subscription_params)
    redirect_to root_path
  end

  private

  def subscription_params
    params.require(:subscription).permit(:stripe_plna_id, :stripe_subscription_id, :is_trial, :trial_expire_at, :plan_expires_at, :status)
  end
end
