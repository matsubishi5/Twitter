class TweetsController < ApplicationController
	def new
		@tweet = Tweet.new
	end

	def create
		@tweet = Tweet.new(tweet_params)
		@tweet.user_id = current_user.id
		@tweet.save
	end

	def index
		@tweet = Tweet.new
		@tweets = Tweet.all.order(id: "DESC")
	end

	def show
		@tweet = Tweet.find(params[:id])
		@comments = @tweet.comments.order(id: "DESC")
		@comment = Comment.new
	end

	def destroy
		if user_signed_in?
			tweet = Tweet.find(params[:id])
			tweet.destroy
			redirect_to tweets_path
		end
	end

	private

	def tweet_params
		params.require(:tweet).permit(:title,:body,:tweet_image)
	end
end
