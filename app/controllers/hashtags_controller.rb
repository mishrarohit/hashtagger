class HashtagsController < ApplicationController

  def new
    @hashtag = Hashtag.new
  end

end
