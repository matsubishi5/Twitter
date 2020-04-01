class User < ApplicationRecord
	devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :validatable

	validates :name, presence: true, uniqueness: true, length: { in: 1..20 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
	validates :password, presence: true, length: { in: 8..20 },on: :sign_up
	validates :introduction, length: { maximum: 100 }

	attachment :profile_image
	attachment :header_image

	has_many :tweets, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	has_many :favorite_tweets, through: :favorites, source: :tweet
	has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
	has_many :following_user, through: :follower, source: :followed
	has_many :follower_user, through: :followed, source: :follower
	has_many :messages, dependent: :destroy
	has_many :entries, dependent: :destroy

	def update_without_current_password(params, *options)
		params.delete(:current_password)

		if params[:password].blank? && params[:password_confirmation].blank?

			params.delete(:password)
			params.delete(:password_confirmation)
		end

		result = update_attributes(params, *options)
		clean_up_passwords
		result
	end

	def follow(user_id)
		follower.create(followed_id: user_id)
	end

	def unfollow(user_id)
		follower.find_by(followed_id: user_id).destroy
	end

	def following?(user)
		following_user.include?(user)
	end

	def User.search(search, user_or_tweet)
	    if user_or_tweet == "1"
	       User.where(['name LIKE ?', "%#{search}%"])
	    else
	       User.all
	    end
	end

    def favorited_by?(tweet_id)
      favorites.where(tweet_id: tweet_id).exists?
    end
end

