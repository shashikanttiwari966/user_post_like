class StripeSubscription
  def initialize(stripe)
    @stripe = stripe
  end

  def create_customer
    Stripe::Customer.new @stripe
  end

  def subscription_list
    Stripe::Subscription.list(customer: @stripe)
  end

  def find_plan_trialday
    Stripe::Plan.retrieve(@stripe).trial_period_days
  end

  def create_subscription(plan,endtrial)
    Stripe::Subscription.create({customer: @stripe,items: [{plan: plan}],trial_end: endtrial })
  end
end