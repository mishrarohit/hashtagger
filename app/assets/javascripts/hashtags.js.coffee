# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  unless $('#hashtag-name').data('hashtag-id') == undefined
      source = new EventSource('/streaming/tweets?id=' + $('#hashtag-name').data('hashtag-id'))
      source.addEventListener 'message', (e) ->
        # console.log e.data
        t = $.parseJSON e.data

        tweet = $('<div class="tweet row"></div>')
        tweet_inner_container = $('<div class="col-xs-12 col-sm-6 col-centered tweet-inner-container"></div>')
        
        tweet_header = $('<div class="tweet-header"></div')
        tweet_header.append '<span class="tweet-creator-name">'+ t.creator_name + '</span>'
        tweet_header.append '<span class="tweet-creator-username"> @' + t.creator_username + '</span>'

        tweet_inner_container.append tweet_header

        tweet_text = $('<span class="tweet-text"></span>')
        tweet_text.append t.text
        tweet_text.append '<br>'

        tweet_inner_container.append tweet_text

        link = 'https://twitter.com/' + t.creator_username + '/status/' + t.twitter_id

        tweet_link = $('<a href="' + link + '" target="_blank">')
        tweet_link.append '<time data-local="time-ago" datetime="' + t.twitter_created_at + '">' + LocalTime.relativeTimeAgo(new Date(Date.parse(t.twitter_created_at))) + '</time>'

        tweet_inner_container.append tweet_link

        # console.log tweet

        tweet.append tweet_inner_container

        $('#tweets-container').prepend tweet



     





# <div class="tweet row">
#   <div class="col-xs-12 col-sm-6 col-centered tweet-inner-container">    
#     <div class="tweet-header">
#       <span class="tweet-creator-name">MODIfied_Indian</span>  
#       <span class="tweet-creator-username">@Prabhash_B</span>  
#     </div>
#     <span class="tweet-text">#WhyPMModi because #AK49 fires bullet which takes u-turn. @SanghParivarOrg @NaMOforPM @ZindegiROCKZ @choriketweet http://t.co/wtxYTGp3vI</span><br>      
#     <a href="https://twitter.com/Prabhash_B/status/449085247057969152" target="_blank">
#       <time data-local="time-ago" datetime="2014-03-27T07:27:21Z">43 minutes ago</time>
# </a>  </div>
# </div>
