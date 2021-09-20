class PaymentController < ApplicationController
	def ipn_webhook
		res_arr = {
		transaction_id: params[:transaction_id],
		total: params[:total],
		payment_status: params[:payment_status],
		}
		TransactionHistory.create(res_arr)
	end
end