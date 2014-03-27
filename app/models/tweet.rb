# == Schema Information
#
# Table name: tweets
#
#  id                 :integer          not null, primary key
#  text               :string(255)
#  creator_name       :string(255)
#  creator_username   :string(255)
#  twitter_id         :string(255)
#  twitter_created_at :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

class Tweet < ActiveRecord::Base

  has_many :hashtag_tweets, dependent: :destroy
end
