class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :title
      t.text :body
      t.string :tweet_image_id
      t.integer :user_id

      t.timestamps
    end
  end
end
