class CreateHashtagTweets < ActiveRecord::Migration
  def change
    create_table :hashtag_tweets do |t|
      t.references :hashtag, index: true
      t.references :tweet, index: true

      t.timestamps
    end
  end
end
