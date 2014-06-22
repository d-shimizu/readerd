#require 'feedzirra'
require 'feedjira'
module FeedAnalyze
  def feed_analyze(feed_url)

           if false && feed.last_modified != nil
             #parsedFeed = Feedjira::Feed.fetch_and_parse "#{@feed_url}", :if_modified_since => feed.last_modified
             parsedFeed = Feedjira::Feed.fetch_and_parse "#{feed_url}", :if_modified_since => feed.last_modified
           else
             #parsedFeed = Feedjira::Feed.fetch_and_parse "#{@feed_url}"
             parsedFeed = Feedjira::Feed.fetch_and_parse "#{feed_url}"
           end

           #if !parsedFeed || parsedFeed.instance_of?(Fixnum)
             #p 'Skipped '+ @feed.url
           #  return nil, nil, nil, nil
           #end

           #url = parsedFeed.url
           #title = parsedFeed.title
           #last_modified = parsedFeed.last_modified
           #feed_url = parsedFeed.feed_url
           #feed = [url, title, last_modified, feed_url]

           # if false && @feed.last_modified != nil
           #   parsedFeed = Feedjira::Feed.fetch_and_parse "#{@feed_url}", :if_modified_since => @feed.last_modified
           # else
           #   parsedFeed = Feedjira::Feed.fetch_and_parse "#{@feed_url}"
           # end

            #if !parsedFeed || parsedFeed.instance_of?(Fixnum)
            #    parsedFeed = Feedjira::Feed.fetch_and_parse "#{@feed_url}", :if_modified_since => @feed.last_modified
            #  else
            #    parsedFeed = Feedjira::Feed.fetch_and_parse "#{@feed_url}"
            #end

            #if !parsedFeed || parsedFeed.instance_of?(Fixnum)
              #p 'Skipped '+ @feed.url
              #return nil, nil, nil, nil
            #end

            @feed.url = parsedFeed.url
            @feed.title = parsedFeed.title
            @feed.last_modified = parsedFeed.last_modified
            @feed.feed_url = parsedFeed.feed_url

    #  feedarrytmp=feedarry.sort { |x,y|
        #x[2] <=> y[2]
    #    x[4] <=> y[4]
    #  }
    #end
    
    #@feed.url = feedarrytmp[0][0]
    #@feed.title = feedarrytmp[0][1]
    #@feed.last_modified = feedarrytmp[0][2]
    #@feed.feed_url = feedarrytmp[0][3]

    #@feed.url = feedarry[0][0]
    #@feed.title = feedarry[0][1]
    #@feed.last_modified = feedarry[0][2]
    #@feed.feed_url = feedarry[0][3]

    #return @feed[0]
    return @feed.title, @feed.url, @feed.feed_url, @feed.last_modified
    #return feedarry
  end
end
