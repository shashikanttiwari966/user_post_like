# module Services
require "stripe"
	class StripePlan < ApplicationService
		def initialize
			
		end

		def stripe_plan
			# Stripe.new().stripe_plan
			debugger
			Stripe::Plan.list.data.sort_by { |e| e[:amount] }
			# Stripe::Subscription.retrieve(subscription)
		end
	end
# end