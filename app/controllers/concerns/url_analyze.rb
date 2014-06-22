#require 'feedzirra'
require 'feedjira'
module UrlAnalyze
  def url_analyze(url)

    feedarry=[]
    begin
      doc = Nokogiri::HTML(open(url),nil,'utf-8')

        doc.css('link').each do |link|
          if (( link['type'] == 'application/rss+xml' || link['type'] == 'application/atom+xml') && link['rel'] == 'alternate')
            href = link['href']
            @feed_url = URI.join(url, href)
            if false && feed.last_modified != nil
              parsedFeed = Feedjira::Feed.fetch_and_parse "#{@feed_url}", :if_modified_since => feed.last_modified
            else
              parsedFeed = Feedjira::Feed.fetch_and_parse "#{@feed_url}"
            end

            if !parsedFeed || parsedFeed.instance_of?(Fixnum)
                parsedFeed = Feedjira::Feed.fetch_and_parse "#{@feed_url}", :if_modified_since => feed.last_modified
              else
                parsedFeed = Feedjira::Feed.fetch_and_parse "#{@feed_url}"
              end

            if !parsedFeed || parsedFeed.instance_of?(Fixnum)
              p 'Skipped '+ @feed.url
              return nil, nil, nil, nil
            end

            url = parsedFeed.url
            title = parsedFeed.title
            last_modified = parsedFeed.last_modified
            feed_url = parsedFeed.feed_url

            feeddata = [url, title, feed_url, last_modified]
            a = 0
            feedarry.insert(a,feeddata)
            a += 1
          end
        end

        if feedarry.empty?
          @feed_url=url
          if false && feed.last_modified != nil
            parsedFeed = Feedjira::Feed.fetch_and_parse "#{@feed_url}", :if_modified_since => feed.last_modified
          else
            parsedFeed = Feedjira::Feed.fetch_and_parse "#{@feed_url}"
          end

          if !parsedFeed || parsedFeed.instance_of?(Fixnum)
            p 'Skipped '+ @feed.url
            return nil, nil, nil, nil
          end

          url = parsedFeed.url
          title = parsedFeed.title
          last_modified = parsedFeed.last_modified
          feed_url = parsedFeed.feed_url
          feeddata = [url, title, feed_url, last_modified]
          a = 0
          feedarry.insert(a,feeddata)
          a += 1
      end
    return feedarry
    rescue
      #return nil, url, nil, nil
      return nil, nil, nil, nil
    end

    #if feedarry.size > 1
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
    #return @feed.title, @feed.url, @feed.feed_url, @feed.last_modified
    #return feedarry
  end
end
