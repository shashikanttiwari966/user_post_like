class TwilioTextMessenger
  require 'rubygems'
  require 'twilio-ruby'
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call
	client = Twilio::REST::Client.new("ACfff810f85d596e7553457f402620e035","dd7af801c74dc4ee15f5c918db010d11")
  client.messages.create({from: "+12397477683", to: "+919131864541", body: "#{@message} #{rand(9999)}" })

  end
end

   
 #    account_sid = ENV['TWILIO_ACCOUNT_SID']
	# auth_token = ENV['TWILIO_AUTH_TOKEN']
	# @client = Twilio::REST::Client.new(account_sid, auth_token)
	# message = @client.messages.create(
 #                             from: '+12397477683',
 #                             body: 'Hi there',
 #                             to: '+919131864541'
 #                           )

	# puts message.sid