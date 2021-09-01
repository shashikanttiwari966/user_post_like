class StripeService
  def initialize()
    
  end

  def plans
    # debugger
    Stripe::Plan.list.data.sort_by { |e| e[:amount] }
    # puts "method is calling"
  end

  def subscribe_plan

  end
end