# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  unless window.hashtagger_eventsource == undefined
    window.hashtagger_eventsource.close()

  unless $('#hashtag-name').data('hashtag-id') == undefined
      window.hashtagger_eventsource = new EventSource('/streaming/tweets?id=' + $('#hashtag-name').data('hashtag-id'))
      window.hashtagger_eventsource.addEventListener 'message', (e) ->
        # console.log e.data
        t = $.parseJSON e.data

        tweet = $('<div class="tweet row"></div>')
        tweet_inner_container = $('<div class="col-xs-12 col-sm-6 col-centered tweet-inner-container"></div>')
        
        tweet_header = $('<div class="tweet-header"></div')
        tweet_header.append '<span class="tweet-creator-name">'+ t.creator_name + '</span>'
        tweet_header.append '<span class="tweet-creator-username"> @' + t.creator_username + '</span>'

        tweet_inner_container.append tweet_header

        tweet_text = $('<p class="tweet-text"></p>')
        tweet_text.append twttr.txt.autoLink(t.text)

        tweet_inner_container.append tweet_text

        link = 'https://twitter.com/' + t.creator_username + '/status/' + t.twitter_id

        tweet_link = $('<a href="' + link + '" target="_blank">')
        tweet_link.append '<time data-local="time-ago" datetime="' + t.twitter_created_at + '">' + LocalTime.relativeTimeAgo(new Date(Date.parse(t.twitter_created_at))) + '</time>'

        tweet_inner_container.append tweet_link

        # console.log tweet

        tweet.append tweet_inner_container

        $('#tweets-container').prepend tweet

$(document).ready(ready)
$(document).on('page:load', ready)
