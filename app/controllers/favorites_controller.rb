class FavoritesController < ApplicationController
    def create
        @tweet = Tweet.find(params[:tweet_id])
        if current_user.favorited_by?(@tweet.id)
        else
            favorite = current_user.favorites.new(tweet_id: @tweet.id)
            favorite.save!
        end
	end

	def destroy
		@tweet = Tweet.find(params[:tweet_id])
        favorite = current_user.favorites.find_by(tweet_id: @tweet.id)
        favorite.destroy
    end

    def index
        @user = User.find(params[:user_id])
        @favorites = @user.favorite_tweets
    end
end
