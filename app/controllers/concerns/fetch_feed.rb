module FetchFeed
  #def feed_fetch(@feed)
  def feed_fetch
        maxid = Feed.maximum('id')
        feed=Feed.find(maxid, :select => "*")
        hash_url=Feed.find(maxid, :select => "url")
        site_url = hash_url['url']
        feed_url = nil

        doc = Nokogiri::HTML(open(site_url),nil,'utf-8')
        doc.css('link').each do |link|
          if link['type'] == 'application/rss+xml' && link['rel'] == 'alternate'
            href = link['href']
            feed_url = URI.join(site_url, href)
            break

          elsif link['type'] == 'application/atom+xml' && link['rel'] == 'alternate'
            href = link['href']
            feed_url = URI.join(site_url, href)
            break

          end
        end

        if false && feed.last_modified != nil
          parsedFeed = Feedzirra::Feed.fetch_and_parse "#{feed_url}", :if_modified_since => feed.last_modified
        else
          parsedFeed = Feedzirra::Feed.fetch_and_parse "#{feed_url}"
        end

        if !parsedFeed || parsedFeed.instance_of?(Fixnum)
          p 'Skipped '+feed.url
        end

        # Update feed meta data
        feed['title'] = parsedFeed.title
        feed['last_modified'] = parsedFeed.last_modified
        feed['feed_url'] = "#{feed_url}"
        if parsedFeed.url != nil  then
          feed['url'] = "#{site_url}"
        end
        feed.save

        tmp = parsedFeed.entries
        parsedFeed_entries_tmp = tmp.sort{|aa, bb|
          aa.published <=> bb.published
        }
        parsedFeed_entries = parsedFeed_entries_tmp.reverse

        # Get latest entry
        latest_entry = Entry.where(:feed_id => feed['id']).order('created_at DESC').first

        # Take updated entries
        if latest_entry != nil
          updatedEntries = parsedFeed_entries.take_while {
            |e| e.published != latest_entry.published_at
          }
        else
          updatedEntries = parsedFeed_entries
        end

        # Save entries
        updatedEntries.reverse.each do |feed_entry|

          if feed_entry.url.include?("#comment-") == false
             p 'Add => ' + feed_entry.url
             p feed_entry.published

             entry = Entry.new({
               :title        => feed_entry.title,
               :url          => feed_entry.url,
               :summary      => (feed_entry.summary || feed_entry.content || '').gsub(/<.+?>/m, '').slice(0, 255),
               :published_at => feed_entry.published,
               :feed_id      => feed.id
             })
             entry.save
          end
       end

  end
end
