require 'feedzirra'
module UrlAnalyze
  #def feed_fetch(@feed)
  def url_analyze(url)
        #maxid = Feed.maximum('id')
        #feed=Feed.find(maxid, :select => "*")
        #hash_url=Feed.find(maxid, :select => "url")
        #site_url = hash_url['url']
        #feed_url = nil

        #doc = Nokogiri::HTML(open(site_url),nil,'utf-8')
  
        begin
          doc = Nokogiri::HTML(open(url),nil,'utf-8')
        rescue
          #return @feed.url
          #return @feed.title, url, @feed.feed_url, @feed.last_modified
          return nil, url, nil, nil
        end
        doc.css('link').each do |link|
          if link['type'] == 'application/rss+xml' && link['rel'] == 'alternate' && link['href'].include?("/comment/") == false && link['href'].include?("/comments/") == false
            href = link['href']
            #new_url= URI.parse(url).scheme + "://" + URI.parse(url).host
            #@feed_url = URI.join(url, href)
            @feed_url = URI.join(url, href)
          elsif link['type'] == 'application/atom+xml' && link['rel'] == 'alternate' && link['href'].include?("/comment/") == false && link['href'].include?("/comments/") == false
            href = link['href']
            #new_url= URI.parse(url).scheme + "://" + URI.parse(url).host
            #@feed_url = URI.join(url, href)
            #@feed_url = URI.join(URI.parse(url).scheme + "://" + URI.parse(url).host, href)
            @feed_url = URI.join(url, href)
          end
        end

        if false && feed.last_modified != nil
          parsedFeed = Feedzirra::Feed.fetch_and_parse "#{@feed_url}", :if_modified_since => feed.last_modified
        else
          parsedFeed = Feedzirra::Feed.fetch_and_parse "#{@feed_url}"
          #parsedFeed = Feedzirra::Feed.fetch_and_parse feed_url
        end

        if !parsedFeed || parsedFeed.instance_of?(Fixnum)
          p 'Skipped '+ @feed.url
          #return parsedFeed.title, parsedFeed.url, parsedFeed.feed_url, parsedFeed.last_modified
          #return false, false, false, false
          return nil, nil, nil, nil
        end

        # Update feed meta data
        #feed['title'] = parsedFeed.title
        #feed['last_modified'] = parsedFeed.last_modified
        #feed['feed_url'] = parsedFeed.feed_url
        #if parsedFeed.url != nil  then
        #if feed.url == nil  then
          #feed['url'] = "#{site_url}"
        #feed['url'] = parsedFeed.url
        #end
        #feed.save

        @feed.url = parsedFeed.url
        @feed.title = parsedFeed.title
        @feed.last_modified = parsedFeed.last_modified
        @feed.feed_url = parsedFeed.feed_url

        return @feed.title, @feed.url, @feed.feed_url, @feed.last_modified
        #return @feed

  end
end
