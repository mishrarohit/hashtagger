class HashtagsController < ApplicationController
  include ActionController::Live

  def new
    @hashtag = Hashtag.new

    @existing_hashtags = Hashtag.order('id DESC').limit(15)
  end

  def create
    @hashtag = Hashtag.where("name ILIKE ?", hashtag_params[:name]).first_or_initialize(name: hashtag_params[:name])

    # Check if this hashtag previously existed
    @new_hashtag = @hashtag.new_record?
    @hashtag.save if @hashtag.new_record?

    if @new_hashtag
      twitter_rest_client = Twitter::REST::Client.new do |config|
        config.consumer_key        = Figaro.env.twitter_consumer_key
        config.consumer_secret     = Figaro.env.twitter_consumer_secret
        config.access_token        = Figaro.env.twitter_access_token
        config.access_token_secret = Figaro.env.twitter_access_token_secret
      end

      query_string = "%23#{@hashtag.name}"
      response = twitter_rest_client.search(query_string)
      
      response.each do |tweet_json|
        @hashtag.create_tweet_from_api_response(tweet_json)
      end
    end

    redirect_to hashtag_path(name: @hashtag.name)
  end

  def show
    @hashtag = Hashtag.find_by!(name: params[:name])

    @tweets = @hashtag.tweets.order('twitter_created_at DESC').limit(500)
  end

  private

  def hashtag_params
    params.require(:hashtag).permit(:name)
  end

end
