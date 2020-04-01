class HomesController < ApplicationController

	def top
	    if user_signed_in?
	    	redirect_to tweets_path
	    else
	        root_path
	    end
	end
end
