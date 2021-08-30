class ApplicationController < ActionController::Base
 require 'stripe' 
 require 'date'

 Stripe.api_key = 'sk_test_51JNaUlSBn2OWJA3igYXVF62Ts0MPHiCtF6DnPm6sd5GDf1xQ4PnuFAOysZlBqlzEA1WV8Vbnp2IuXXXz5MbQRASa00NfEqWiFF'

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
	 def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,
        keys: [ :email, :user_name, :password, :admin, :role, :password_confirmation])
      devise_parameter_sanitizer.permit(:sign_in,
        keys: [:login, :password, :password_confirmation])
      devise_parameter_sanitizer.permit(:account_update,
        keys: [:user_name, :email, :admin, :role, :password_confirmation, :current_password])
    end
end
