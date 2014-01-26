require 'feedzirra'
module UrlAnalyze
  def url_analyze(url)
  
        begin
          doc = Nokogiri::HTML(open(url),nil,'utf-8')
        rescue
          return nil, url, nil, nil
        end

        doc.css('link').each do |link|
          if link['type'] == 'application/rss+xml' && link['rel'] == 'alternate' && link['href'].include?("/comment/") == false && link['href'].include?("/comments/") == false
            href = link['href']
            @feed_url = URI.join(url, href)
          elsif link['type'] == 'application/atom+xml' && link['rel'] == 'alternate' && link['href'].include?("/comment/") == false && link['href'].include?("/comments/") == false
            href = link['href']
            @feed_url = URI.join(url, href)
          end
        end

        if false && feed.last_modified != nil
          parsedFeed = Feedzirra::Feed.fetch_and_parse "#{@feed_url}", :if_modified_since => feed.last_modified
        else
          parsedFeed = Feedzirra::Feed.fetch_and_parse "#{@feed_url}"
        end

        if !parsedFeed || parsedFeed.instance_of?(Fixnum)
          p 'Skipped '+ @feed.url
          return nil, nil, nil, nil
        end

        @feed.url = parsedFeed.url
        @feed.title = parsedFeed.title
        @feed.last_modified = parsedFeed.last_modified
        @feed.feed_url = parsedFeed.feed_url

        return @feed.title, @feed.url, @feed.feed_url, @feed.last_modified

  end
end
