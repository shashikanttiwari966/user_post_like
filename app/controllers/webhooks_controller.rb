class WebhooksController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_authenticity_token
  def create
    debugger
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials.dig(:stripe, :webhook)
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      puts "Signature error"
      p e
      return
    end

    # Handle the event
    case event.type
    when 'checkout.session.completed'
      session = event.data.object
      @user = User.find_by(stripe_id: session.customer)
      @user.subscription.update(subscription_status: 'active')

    when 'customer.subscription.updated', 'customer.subscription.deleted'
      subs = event.data.object
        if subs.items.data[0].plan.trial_period_days.blank?
          trial = false
        else
          trial = true
        end     
      @user = User.find_by(stripe_id: subs.customer)
      debugger
      @user.subscription.update(
        stripe_plna_id: subs.items.data[0].plan.id,
        stripe_subscription_id: subs.id,
        is_trial: trial,
        trial_expire_at: subs.trial_end,
        plan_expires_at: subs.trial_start,
        status: subs.status,
        subscription_status: subs.status)
        redirect_to root_path, notice:"successfull update subcription"
    end

    render json: { message: 'success' }
  end
end