class PhoneNumbersController < ApplicationController
	def new
	  @phone_number = PhoneNumber.new
	  @user = User.find(params[:user])
	end

	def create
	  
	  @user = User.find(params[:user])
	  @phone = params[:phone_number][:phone_number]
	  if @user.phone_no == @phone
	  	  @phone_number = PhoneNumber.find_or_create_by(phone_number: params[:phone_number][:phone_number]) 
		  @phone_number.generate_pin
		  @phone_number.send_pin
		  respond_to do |format|
		    format.js # render app/views/phone_numbers/create.js.erb
		  end
	  else
	  	  flash[:alert] = "invalid PhoneNumber"
	  	  render :new
	  end	  
	end

	def verify
	  @user = User.find(params[:user])
	  @phone_number = PhoneNumber.find_by(phone_number: params[:hidden_phone_number])
	  if @phone_number.verify(params[:pin])
	  	sign_in @user
	  	return redirect_to root_path, notice:"successfull"
	  else
	  	flash[:alert] = 'invalid OTP!'
	 	return render :new
	 end
	end
end
