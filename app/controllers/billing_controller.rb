class BillingController < ApplicationController
   before_action :authenticate_user!

  #  enum status: {
  #   trialing: 'trialing',
  #   active: 'active',
  #   past_due: 'past_due',
  #   canceled: 'canceled',
  # }

  def index
   @user = current_user.email
  end

  # def customer_info
  #   @customer = Stripe::Customer.retrieve(id:current_user.stripe_id)
  # end

	def new_card
    @amount = params[:amount]
    @plan = params[:plan]
    respond_to do |format|
      format.js
    end
  end

  def subscribe
    #we define our customer
    card_token = params[:stripeToken]
    customer = StripeSubscription.new(current_user.stripe_id).create_customer
    customer.source = card_token
    customer.save
    
    #we delete all subscription that the customer has. We do this because we don't want that our customer to have multiple subscriptions
    subscriptions = StripeSubscription.new(customer.id).subscription_list
    subscriptions.each do |subscription|
      subscription.delete
    end

    #we are creating a new subscription with the plan_id we took from our form
    plan_id = params[:plan_id]
    trial_days = StripeSubscription.new(plan_id).find_plan_trialday
    subscription = StripeSubscription.new(customer).create_subscription(plan_id,(Time.now+trial_days.day).to_i)
    subscription.save

    if subscription.items.first.plan.trial_period_days == nil
      trial = false
    else
      trial = true
    end

    #delete previous subscriptions
    if subscriptions = current_user.subscription
    subscriptions.delete
    end

    #create subscription for application
    @subscription = current_user.create_subscription(stripe_plna_id:subscription.items.first.plan.id, stripe_subscription_id:subscription.id, is_trial: trial,trial_expire_at:Time.at(subscription.trial_end),plan_expires_at:Time.at(subscription.current_period_end), status:subscription.status)
    redirect_to root_path, notice:"Subscribed plan"
  end

  def webhook
    debugger
  end
end
  