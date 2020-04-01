class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@tweets = @user.tweets
	    @currentUserEntry=Entry.where(user_id: current_user.id)
	    @userEntry=Entry.where(user_id: @user.id)
	    if @user.id == current_user.id
	    else
	      @currentUserEntry.each do |cu|
	        @userEntry.each do |u|
	          if cu.room_id == u.room_id then
	            @isRoom = true
	            @roomId = cu.room_id
	          end
	        end
	      end
	      if @isRoom
	      else
	        @room = Room.new
	        @entry = Entry.new
	      end
	    end
	end

	def following
		@user = User.find(params[:user_id])
	end

	def follower
		@user = User.find(params[:user_id])
	end

	def search
		@user_or_tweet = params[:option]
	if @user_or_tweet == "1"
	  	@users = User.search(params[:search], @user_or_tweet)
	else
	  	@tweets = Tweet.search(params[:search], @user_or_tweet)
	end
	end
end
