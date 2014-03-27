class StreamingController < ApplicationController 
  include ActionController::Live

  def tweets
    response.headers["Content-Type"] = "text/event-stream"
    @hashtag = Hashtag.find params[:id]
    # logger.info "HASHTAG == #{@hashtag.name}"

    client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = Figaro.env.twitter_consumer_key
      config.consumer_secret     = Figaro.env.twitter_consumer_secret
      config.access_token        = Figaro.env.twitter_access_token
      config.access_token_secret = Figaro.env.twitter_access_token_secret
    end

    client.filter(:track => "##{@hashtag.name}") do |object|
      # logger.info "#{pp object.text}...\n\n" if object.is_a?(Twitter::Tweet)
      tweet = @hashtag.create_tweet_from_api_response(object)
      response.stream.write "data: #{tweet.to_json}\n\n" if object.is_a?(Twitter::Tweet)
    end
  rescue IOError
    logger.info "=============== Stream closed ============="
  ensure
    response.stream.close
  end
end