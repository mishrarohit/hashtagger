# == Schema Information
#
# Table name: hashtag_tweets
#
#  id         :integer          not null, primary key
#  hashtag_id :integer
#  tweet_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class HashtagTweet < ActiveRecord::Base
  belongs_to :hashtag
  belongs_to :tweet
end
