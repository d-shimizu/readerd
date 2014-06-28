#require 'feedzirra'
require 'feedjira'
module FeedAnalyze
  def feed_analyze(feed_url)

    if false && feed.last_modified != nil
      parsedFeed = Feedjira::Feed.fetch_and_parse "#{feed_url}", :if_modified_since => feed.last_modified
    else
      parsedFeed = Feedjira::Feed.fetch_and_parse "#{feed_url}"
    end

    @feed.url = parsedFeed.url
    @feed.title = parsedFeed.title
    @feed.last_modified = parsedFeed.last_modified
    @feed.feed_url = parsedFeed.feed_url

    return @feed.title, @feed.url, @feed.feed_url, @feed.last_modified

  end
end
