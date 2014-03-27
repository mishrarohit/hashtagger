class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.string :creator_name
      t.string :creator_username
      t.string :twitter_id
      t.datetime :twitter_created_at

      t.timestamps
    end

    add_index :tweets, :twitter_id
    add_index :tweets, :twitter_created_at
  end
end
