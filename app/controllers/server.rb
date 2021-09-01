class ServerController < ApplicationController
# Use this sample code to handle webhook events in your integration.
#
# 1) Paste this code into a new file (server.rb)
#
# 2) Install dependencies
#   gem install sinatra
#   gem install stripe
#
# 3) Run the server on http://localhost:4242
#   ruby server.rb

require 'json'
require 'sinatra'
require 'stripe'

# This is your Stripe CLI webhook secret for testing your endpoint locally.
endpoint_secret = 'whsec_o4UCjsAgnXM7nKi7D7rYW6412RWUEKQx'

set :port, 4242

post '/webhook' do
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
        event = Stripe::Webhook.construct_event(
            payload, sig_header, endpoint_secret
        )
    rescue JSON::ParserError => e
        # Invalid payload
        status 400
        return
    rescue Stripe::SignatureVerificationError => e
        # Invalid signature
        status 400
        return
    end

    # Handle the event
    case event.type
    when 'source.canceled'
        source = event.data.object
    when 'source.chargeable'
        source = event.data.object
    when 'source.failed'
        source = event.data.object
    when 'source.mandate_notification'
        source = event.data.object
    when 'source.refund_attributes_required'
        source = event.data.object
    when 'source.transaction.created'
        source = event.data.object
    when 'source.transaction.updated'
        source = event.data.object
    when 'subscription_schedule.aborted'
        subscription_schedule = event.data.object
    when 'subscription_schedule.canceled'
        subscription_schedule = event.data.object
    when 'subscription_schedule.completed'
        subscription_schedule = event.data.object
    when 'subscription_schedule.created'
        subscription_schedule = event.data.object
    when 'subscription_schedule.expiring'
        subscription_schedule = event.data.object
    when 'subscription_schedule.released'
        subscription_schedule = event.data.object
    when 'subscription_schedule.updated'
        subscription_schedule = event.data.object
    # ... handle other event types
    else
        puts "Unhandled event type: #{event.type}"
    end

    status 200
end
end