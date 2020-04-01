class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters,if: :devise_controller?

	def after_sign_in_path_for(resource)
	  tweets_path
	end

	def after_sign_out_path_for(resource)
	  root_path
	end

    private

	def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
	  devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :profile_image,:header_image,:birthday])
	end


end