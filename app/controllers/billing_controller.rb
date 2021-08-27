class BillingController < ApplicationController
   before_action :authenticate_user!

  def index
   @user = current_user.email
  end

  def customer_info
    @customer = Stripe::Customer.retrieve(id:current_user.stripe_id)
  end

	def new_card
    @amount = params[:amount]
    @plan = params[:plan]
    @trial_days = Stripe::Plan.retrieve('price_1JSImCSBn2OWJA3itaHDXMzv').trial_period_days
    respond_to do |format|
      format.js
    end
  end

  def subscribe
      if current_user.stripe_id.nil?
        redirect_to success_path, :flash => {:error => 'Firstly you need to enter your card'}
        return
      end
      #if there is no card
      card_token = params[:stripeToken]
      customer = Stripe::Customer.new current_user.stripe_id
      customer.source = card_token
      customer.save
      #we define our customer

      subscriptions = Stripe::Subscription.list(customer: customer.id)
      subscriptions.each do |subscription|
        subscription.delete
      end
      #we delete all subscription that the customer has. We do this because we don't want that our customer to have multiple subscriptions
      
      plan_id = params[:plan_id]
      subscription = Stripe::Subscription.create({customer: customer,items: [{plan: plan_id}]})
      #we are creating a new subscription with the plan_id we took from our form
      subscription.save

      #update Subscription for end of free trial
      trial_end = subscription.billing_cycle_anchor + subscription.items.first.plan.trial_period_days.days
      update_sub = Stripe::Subscription.update(subscription.id,{trial_end: trial_end,})
      plan_ex_time = DateTime.now+subscription.items.first.plan.trial_period_days.to_i

      if subscription.items.first.plan.trial_period_days == nil
        trial = false
      else
        trial = true
      end

      if subscriptions = current_user.subscription
      subscriptions.delete
      end

      #create subscription for application
      @subscription = current_user.create_subscription(stripe_plna_id:subscription.items.first.plan.id, stripe_subscription_id:subscription.id, is_trial: trial,trial_expire_at:Time.at(update_sub.trial_end),plan_expires_at:Time.at(subscription.current_period_end), status:update_sub.status)
      # debugger
      redirect_to root_path, notice:"Subscribed plan"
  end
end
  