class CommentsController < ApplicationController
    def create
        tweet = Tweet.find(params[:tweet_id])
        comment = Comment.new(comment_params)
        comment.user_id = current_user.id
        comment.tweet_id = tweet.id
        comment.save
        redirect_to tweet_path(tweet)
    end

    private
    def comment_params
        params.require(:comment).permit(:body)
    end
end
