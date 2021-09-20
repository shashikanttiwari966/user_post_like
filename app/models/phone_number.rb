class PhoneNumber < ApplicationRecord

	def generate_pin
	  self.pin = rand(0000..9999).to_s.rjust(4, "0")
	  save
	end

	def send_pin
	  twilio_client.messages.create(
	    to: phone_number,
	    from: "+12397477683",
	    body: "Your PIN is #{pin}"
	  )
	end

	def twilio_client
	  client = Twilio::REST::Client.new("ACfff810f85d596e7553457f402620e035","dd7af801c74dc4ee15f5c918db010d11")
	end

	def verify(entered_pin)
	  update(verified: true) if self.pin == entered_pin
	end
end
