# == Schema Information
#
# Table name: hashtags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Hashtag < ActiveRecord::Base

  has_many :hashtag_tweets, dependent: :destroy
  has_many :tweets, through: :hashtag_tweets

  def create_tweets_from_api_response(response)
    response.each do |tweet_json|
      tweet = Tweet.where(twitter_id: tweet_json.id.to_s).first_or_create(
        text: tweet_json.text, 
        creator_name: tweet_json.user.name, 
        creator_username: tweet_json.user.screen_name,
        twitter_created_at: tweet_json.created_at )

      self.hashtag_tweets.create(tweet_id: tweet.id)
    end
  end
end
