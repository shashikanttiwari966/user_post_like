module WelcomeHelper
	def product_detail product
		Stripe::Product.retrieve(product)
	end

	def subscription_retrieve subscription 
		Stripe::Subscription.retrieve(subscription)
	end
end
